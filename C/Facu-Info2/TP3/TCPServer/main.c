////////////////////////////////////////////////////////////////////////////////
//                          INFORMATICA II
//
// TP 3: Comunicacion interproceso mediante TCP/IP
//
// RESUMEN:
//
//      Programa servidor al que deberan conectarse los alumnos para participar
//  en el sistema de chat global que administra este server.
//
//	Extra:
//		- Al conectarse un nuevo usuario les avisa a todos los restantes
//		- Lo mismo cuando se desconecta
//		- Al cambiarse el alias algun usuario, tambien avisa al resto del cambio
//
////////////////////////////////////////////////////////////////////////////////

#include<stdio.h>
#include<winsock2.h> //Winsock Library ws2_32.lib
#include "MessageStructs.h"

// Maxima cantidad de clientes que pueden estar conectados
#define MAX_CLIENTS 30

struct user
{
    char name[20];
    SOCKET userSocket;
    int isLoopBackActive;
};

int main(int argc , char *argv[])
{
    WSADATA wsa;
    SOCKET master , new_socket , s;
    SOCKADDR_IN server, address;
    int addrlen, i, j, valread;
    struct user users[30];
    struct mensaje respuesta, recibido;


    ////////////////////////////////////////////////// INICIALIZACION //////////////////////////////////////////////

    //set of socket descriptors
    fd_set readfds;

    // Inicializacion de los espacios para guardar los sockets
    for(i = 0 ; i < MAX_CLIENTS;i++)
    {
        users[i].userSocket = 0;
        users[i].isLoopBackActive = 0;
    }


    // Se inicializa la Winsock con WSAStartup en la version 2.2
    printf("\nInicializando Winsock...\n");

    if (WSAStartup(MAKEWORD(2,2),&wsa) != 0)
    {
        printf("Failed. Error Code : %d",WSAGetLastError());
        exit(EXIT_FAILURE);
    }

    printf("Winsock Inicializado.\n");

    //Crear socket. usamos AF_NET (IPv4, SOCK_STREAM (TCP bidireccional basico), 0 (dejamos elegir el protocolo al service provider)
    if((master = socket(AF_INET , SOCK_STREAM , 0 )) == INVALID_SOCKET)
    {
        printf("No se pudo crear el socket socket : %d\n" , WSAGetLastError());
        exit(EXIT_FAILURE);
    }

    printf("Socket creado.\n");

    //Preparar la estructura del sockaddr
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY;
    server.sin_port = htons(SERVER_PORT);

    //Bind (Vincular el socket)
    if( bind(master ,(struct sockaddr *)&server , sizeof(server)) == SOCKET_ERROR )
    {
        printf("Fallo el bind -> error code : %d\n" , WSAGetLastError());
        exit(EXIT_FAILURE);
    }

    puts("Bind listo\n");

    //Empezar a escuchar el puerto
    listen(master , 3);



    //////////////////////////////////////// ACA EMPIEZA LA ESCUCHA DEL PUERTO ////////////////////////////////////////////////



    // De ahora en adelante, esperamos nuevas conexiones entrantes y mensajes.
    // El socket que se abrió es unicamente para que los clientes se conecten, luego son derivados a otro socket.
    puts("Esperando conexiones entrantes....\n");

    addrlen = sizeof(struct sockaddr_in);

    while(1)
    {
        //Reiniciar el socket fd_set- El fd_set es una estrcutura usada por algunas funciones del
        // winsock para definir condiciones a evaluear del socket.
        FD_ZERO(&readfds);

        // añadir al socket principal para conexiones entrantes al fd_set. Lo seteamos para detectar
        // una lectura disponible sobre el puerto.
        FD_SET(master, &readfds);

        // A su vez, para la misma condicion, añadimos los sockets asignados a los clientes ya conectados.
        // En la primer vuelta del programa esto no hace nada, pero a medida que se vayan conectando vamos
        // a querer saber con el select si alguno de nuestros clientes quizo mandar un mensaje.
        for (  i = 0 ; i < MAX_CLIENTS ; i++)
        {
            if(users[i].userSocket > 0)
            {
                FD_SET( users[i].userSocket , &readfds);
            }
        }

        // Congelamos la aplicación en espera de que algun cliente se quiera conectar, o de que
        // algun cliente ya conectado nos envie un mensaje.
        if ( select( 0 , &readfds , NULL , NULL , NULL) == SOCKET_ERROR )
        {
            printf("select fallido -> error code : %d\n" , WSAGetLastError());
            exit(EXIT_FAILURE);
        }

        // Si llegamos a este punto, significa que debemos resolver algun mensaje. Lo primero es evaluar si se trata
        // de una solicitud de conexion o de un mensaje que se debe procesar. Para averiguarlo, solo debemos verificar
        // si el disparador fue el socket master o uno de los generados para los clientes.
        if (FD_ISSET(master , &readfds))
        {
            // Como vino del master, devolvemos una aceptacion de la conexion al cliente.
            if ((new_socket = accept(master , (struct sockaddr *)&address, (int *)&addrlen))<0)
            {
                printf("ERROR: accept\n");
                exit(EXIT_FAILURE);
            }

            // Le ponemos una notificacion en consola del server de que ocurrio una conexion.
            printf("Nueva conexion: socket fd es %d , ip es : %s , port : %d \n" , new_socket , inet_ntoa(address.sin_addr) , ntohs(address.sin_port));

            // Guardamos el socket del nuevo cliente conectado.
            for (i = 0; i < MAX_CLIENTS; i++)
            {
                if (users[i].userSocket == 0)
                {
                    strcpy(users[i].name, inet_ntoa(address.sin_addr));
                    users[i].userSocket = new_socket;
                    users[i].isLoopBackActive = 1;
                    printf("Se agrego cliente al indice %d \n" , i);
                    break;
                }
            }

            respuesta.idMensaje = NUEVO_MENSAJE;
            sprintf(respuesta.mensaje, "SERVER>> El usuario <%s> ha unido a la sala\n", users[i].name);
            for (j = 0; j < MAX_CLIENTS; j++)
            {
                if ((i == j && users[j].isLoopBackActive) || (i != j && users[j].userSocket != 0))
                    send(users[j].userSocket, (char*)&respuesta, sizeof (struct mensaje), 0);
            }
        }

        // Revisamos los sockets de los clientes para ver si alguno mando un mensaje.
        for (i = 0; i < MAX_CLIENTS; i++)
        {
            s = users[i].userSocket;

            // Verificamos si disparo el fd_set
            if (FD_ISSET( s , &readfds))
            {
                // Tomamos los datos del cliente que se conecto con nosotros.
                getpeername(s , (SOCKADDR*)&address , (int*)&addrlen);

                // Verificamos si es por una desconexion. valread va a ser SOCKET_ERROR si se cerro por algun error
                // (ej: la aplicacion cliente crasheo) o 0 si el cliente hizo un shutdown.
                valread = recv( s , (char*)&recibido, sizeof(struct mensaje), 0);

                if( valread == SOCKET_ERROR)
                {
                    int error_code = WSAGetLastError();
                    if(error_code == WSAECONNRESET)
                    {
                        // Si se desconectó generando error, cerramos el socket, y liberamos el espacio en el array, para reusarlo con otro cliente.
                        printf("Host desconectado de forma inesperada , ip %s , port %d, name: %s\n" , inet_ntoa(address.sin_addr) , ntohs(address.sin_port), users[i].name);

                        respuesta.idMensaje = NUEVO_MENSAJE;
                        sprintf(respuesta.mensaje, "SERVER>> El usuario <%s> se ha desconectado\n", users[i].name);
                        for (j = 0; j < MAX_CLIENTS; j++)
                        {
                            if ((i == j && users[j].isLoopBackActive) || (i != j && users[j].userSocket != 0))
                                send(users[j].userSocket, (char*)&respuesta, sizeof (struct mensaje), 0);
                        }

                        closesocket( s );
                        users[i].userSocket = 0;
                    }
                    else
                    {
                        // Si el error no fue WSAECONNRESET, entonces fallo otra cosa. Ponemos en consola para averiguar que fue.
                        printf("recv failed with error code : %d  name: %s\n" , error_code, users[i].name);
                    }
                }

                // Si fue 0, el cliente dio aviso de querer cerrar la conexion
                else if ( valread == 0 )
                {
                    //Como en el otro caso, cerramos el socket de nuestro lado, y liberamos el espacio en el array de clientes.
                    printf("Host desconectado , ip %s , port %d  name: %s\n" , inet_ntoa(address.sin_addr) , ntohs(address.sin_port), users[i].name);

                    respuesta.idMensaje = NUEVO_MENSAJE;
                    sprintf(respuesta.mensaje, "SERVER>> El usuario <%s> se ha desconectado\n", users[i].name);
                    for (j = 0; j < MAX_CLIENTS; j++)
                    {
                        if ((i == j && users[j].isLoopBackActive) || (i != j && users[j].userSocket != 0))
                            send(users[j].userSocket, (char*)&respuesta, sizeof (struct mensaje), 0);
                    }

                    closesocket( s );
                    users[i].userSocket = 0;
                }

                // Finalmente, si recibimos algo ditinto de 0, tenemos un mensaje para procesar.
                else
                {
                    int longitudMensaje = 0;

                    switch(recibido.idMensaje)
                    {
                        case DEFINIR_USUARIO:
                            longitudMensaje = strlen(recibido.mensaje);
                            if (longitudMensaje <= 0 || longitudMensaje > MAX_NAME_LEN)
                            {
                                printf("EL usuario %s quizo definir un nombre de usuario invalido (%s)\n", users[i].name, recibido.mensaje);
                                respuesta.idMensaje = MENSAJE_ERROR;
                                strcpy(respuesta.mensaje, "Nombre de usuario invalido");

                            }
                            else
                            {
                                printf("El usuario %s desea definir su nombre de usuario como %s\n", users[i].name, recibido.mensaje);

                                respuesta.idMensaje = NUEVO_MENSAJE;
                                sprintf(respuesta.mensaje, "SERVER>> El usuario <%s> se cambio su alias por <%s>\n", users[i].name, recibido.mensaje);
                                for (j = 0; j < MAX_CLIENTS; j++)
                                {
                                    if ((i == j && users[j].isLoopBackActive) || (i != j && users[j].userSocket != 0))
                                        send(users[j].userSocket, (char*)&respuesta, sizeof (struct mensaje), 0);
                                }

                                strcpy(users[i].name, recibido.mensaje);
                                respuesta.idMensaje = MENSAJE_OK;
                                strcpy(respuesta.mensaje, users[i].name);
                            }

                            send(s, (char*)&respuesta, sizeof (struct mensaje), 0);
                            break;


                        case ENVIAR_MENSAJE:
                            respuesta.idMensaje = NUEVO_MENSAJE;
                            strcpy(respuesta.mensaje, recibido.mensaje);

                            printf("%s: %s\n", users[i].name, recibido.mensaje);
                            sprintf(respuesta.mensaje, "%s: %s", users[i].name, recibido.mensaje);

                            for (j = 0; j < MAX_CLIENTS; j++)
                            {
                                if ((i == j && users[j].isLoopBackActive) || (i != j && users[j].userSocket != 0))
                                    send(users[j].userSocket, (char*)&respuesta, sizeof (struct mensaje), 0);
                            }
                            break;


                        case ENVIAR_LOOPBACK:
                            printf("El usuario %s envio un mensaje de LoopBack\n", users[i].name);
                            send(s, (char*)&recibido, sizeof (struct mensaje), 0);
                            break;


                        case DESHAB_RETORNO_MENSAJE:
                            printf("El usuario %s deshabilito su loopback de mensajes\n", users[i].name);
                            users[i].isLoopBackActive = 0;
                            respuesta.idMensaje = MENSAJE_OK;
                            strcpy(respuesta.mensaje, users[i].name);
                            send(s, (char*)&respuesta, sizeof (struct mensaje), 0);
                            break;


                        case HAB_RETORNO_MENSAJE:
                            printf("El usuario %s habilito su loopback de mensajes\n", users[i].name);
                            users[i].isLoopBackActive = 1;
                            respuesta.idMensaje = MENSAJE_OK;
                            strcpy(respuesta.mensaje, users[i].name);
                            send(s, (char*)&respuesta, sizeof (struct mensaje), 0);
                            break;


                        default:
                            printf("EL usuario %s envio un mensaje desconocido\n", users[i].name);
                            respuesta.idMensaje = MENSAJE_ERROR;
                            strcpy(respuesta.mensaje, "No se reconoce el mensaje. Verifique el id enviado");
                            send(s, (char*)&respuesta, sizeof (struct mensaje), 0);
                            break;

                    }
                }
            }
        }
    }

    // Esto en teoria no llega nunca, y si se cae la aplicacion, el socket se cierra solo.
    // pero asi es como se hace el cerrado del socket principal y se libera el winsock.
    closesocket(s);
    WSACleanup();

    return 0;
}
