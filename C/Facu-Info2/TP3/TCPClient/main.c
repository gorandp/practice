/* Agregado lib Winsock: Click derecho sobre el nombre del proyecto > build options > linker > agregar C:\Program Files (x86)\CodeBlocks\MinGW\lib\libws2_32.a*/
/* Pagina con codigos ascii para caracteres CTRL+[char] -> http://jkorpela.fi/chars/c0.html */

///////////////////////////////////////////////////////////////////////////////
//                          INFORMATICA II
//
// TP 3: Comunicacion interproceso mediante TCP/IP
//
// Funcionalidades cliente:
//      * Se establece alias apenas se inicia el programa (aunque se puede cambiar en cualquier momento con CTRL+X = 24 (cod. ascii).
//      * Se puede enviar y recibir mensajes.
//      * Se puede limpiar la pantalla con CTRL+Z = 26 (cod. ascii)
//      * El usuario puede terminar el programa con la tecla Escape = 27 (cod. ascii)
//
///////////////////////////////////////////////////////////////////////////////
#include <string.h>
#include <stdio.h>
#include <conio.h>
#include <winsock2.h>
#include <ctype.h>
#include "MessageStructs.h"


// Direccion del Server al que hay que conectarse por defecto.
#define DEFAULT_SERVER_IP_ADDRESS "127.0.0.1"
#define CTRL_Z 26
#define CTRL_X 24
#define ESCAPE 27

int kbhit();
int getch();
char * ObtenerIp(char * ip);
void charADD(char *cad, char p);
void backspace(char *cad);
void head();

int main()
{
    WSADATA WSAData;
    SOCKET cliente;
    SOCKADDR_IN addr;
    TIMEVAL timeout;
    fd_set readsock;
    int sel,i;
    char p;
    char ip[100];
    struct mensaje in;
    struct mensaje out;

    /////////////////////////////// INICIALIZACION ///////////////////////////////

    // Inicializacion del timeout para select no bloqueante
    timeout.tv_sec = 0;
    timeout.tv_usec = 5*1000;

    // Se inicializa la Winsock con WSAStartup en la version 2.2
    printf("Inicializando Winsock...\n");

    if (WSAStartup(MAKEWORD(2,2),&WSAData) != 0)
    {
        printf("Failed. Error Code : %d",WSAGetLastError());
        exit(EXIT_FAILURE);
    }

    printf("Winsock inicializado\n");

    //Se crea socket
    if((cliente = socket(AF_INET , SOCK_STREAM , 0 )) == INVALID_SOCKET)
    {
        printf("No se pudo crear el socket socket : %d\n" , WSAGetLastError());
        exit(EXIT_FAILURE);
    }

    printf("Socket creado.\n");

    // Preparar la estructura del sockaddr. Basicamente, especificamos a donde nos conectamos.
	// El primero es la ip, que la obtenemos por teclado, la familia es AF_NET (IPv4), y
	// el puerto del server.
    addr.sin_addr.s_addr = inet_addr(ObtenerIp(ip));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(SERVER_PORT);

    //Conectarse al server
	if( connect(cliente ,(struct sockaddr *)&addr , sizeof(addr)) == SOCKET_ERROR )
    {
        printf("Fallo el bind -> error code : %d\n" , WSAGetLastError());
        exit(EXIT_FAILURE);
    }

    printf("Conectado al server!\n");



    ////////////////////////// INTERPRETACCION DE MENSAJES Y ESCRITURA //////////////////////

    printf("Ingrese un alias: ");
    gets(out.mensaje);
    out.idMensaje = 1;
    send(cliente,(char*)(&out),sizeof(struct mensaje),0);
    out.mensaje[0] = '\0';
    out.idMensaje = 2;
    p = 0;
    head();//funcion para limpiar pantalla

    while(p != ESCAPE)
    {
        FD_ZERO(&readsock);
        FD_SET(cliente, &readsock);

        sel = select( 0 , &readsock , NULL , NULL , &timeout);
        if(sel == SOCKET_ERROR)
		{
		    printf("select fallido -> error code : %d\n" , WSAGetLastError());
            exit(EXIT_FAILURE);
		}
		else if(sel > 0)
		{
            recv(cliente,(char*)&in,sizeof(struct mensaje),0);

            if(in.idMensaje == NUEVO_MENSAJE)
            {
                printf("%c",'\r');                  //Se vuelve al inicio de la linea
                for(i=0; i<120; i++) printf(" ");    //Se limpia la linea completa
                printf("%c%s", '\r', in.mensaje);   //Se vuelve al inicio de linea, se sobreescribe lo que hay en pantalla
                printf("%s", out.mensaje);          //Se vuelve a escribir por pantalla lo que el cliente tenia escrito
            }
        }

        if(kbhit()!=0)
        {
            p = getche();
            fflush(stdin);

            if(p == '\r')
            {
                p = '\n';
                charADD(out.mensaje,p);
                send(cliente,(char*)(&out),sizeof(struct mensaje),0);
                out.mensaje[0] = '\0';
            }
            else if(p == '\b')
            {
                backspace(out.mensaje);
                printf(" %c",'\b');
            }
            else if(p == CTRL_Z)
            {
                head(); //Limpieza de pantalla
            }
            else if(p == CTRL_X)
            {
                printf("%cIngrese un alias: ", '\r');
                gets(out.mensaje);
                out.idMensaje = 1;
                send(cliente,(char*)(&out),sizeof(struct mensaje),0);
                out.mensaje[0] = '\0';
                out.idMensaje = 2;
            }
            else
            {
                charADD(out.mensaje,p);
            }
            //Si el usuario ingresa escape, se termina el programa
        }
    }

    // Desconexion normal del socket
    if (shutdown(cliente, SD_SEND) == SOCKET_ERROR)
    {
        printf("Fallo el shutdown del socket.\n");
    }

    // Se cierra la instancia del socket
    closesocket(cliente);
    WSACleanup();

    printf("Socket cerrado\n");

    return 0;
}

void charADD(char *cad, char p)
{
    while(*cad != '\0') cad++;
    *cad = p;
    *(cad+1) = '\0';
    return;
}

void backspace(char *cad)
{
    char* p;

    p = cad;
    while(*p != '\0') p++;

    if(p != cad)
    {
        *(p-1) = '\0';
    }

    return;
}

void head()
{
    system("cls");
    printf("\tWhatsApp version UTN FRSN\n");
    printf("==========================================\n");
    printf("Para salir presione la tecla <escape>\n");
    printf("Para limpiar la pantalla presione CTRL+Z\n");
	printf("Para cambiar su alias ingrese CTRL+X\n");
    printf("=========================================\n");
}

// Obtiene la ip del server del usuario. En caso de dejar el campo vacio, se toma la ip local.
char * ObtenerIp(char * ip)
{
    // ipOK: la ip fue validada correctamente. Primero se asume que es valida, a menos que falle en cumplir una condicion.
    // longitudIp: En realidad es la longitud de la cadena donde se ingreso la ip
    // i: Contador generico para recorrer lo leido y validar.
    // cantPuntos: Una IP tiene 3 puntos, o 4 octetos.
    // num: Temporal para la validacion de los octetos.
    // posConversion: para recorrer el string temporal de conversion.

    int ipOk = 0, longitudIp = 0, i = 0, cantPuntos = 0, num = 0, posConversion = 0;
    char octeto[20];

    while(!ipOk)
    {
        ipOk = 1, longitudIp = 0, i = 0, cantPuntos = 0, num = 0, posConversion = 0;

        printf("Ingrese la ip del servidor (127.0.0.1): ");
        gets(ip);
        longitudIp = strlen(ip);

        // Si no se ingreso nada, entonces queire la IP por defecto.
        if (longitudIp == 0)
        {
            printf("Ip por default 127.0.0.1\n");
            strcpy(ip, DEFAULT_SERVER_IP_ADDRESS);
        }

        // Sino validamos la longitud de la IP, que como minimo es "0.0.0.0", y como maximo "255.255.255.255"
        else if (longitudIp < 8 || longitudIp > 16)
        {
            printf("IP de longitud incorrecta\n");
            ipOk = 0;
        }

        // Como supero las otras validaciones, entonces empezamos a ver más fino, caracter por caracter.
        else
        {
            for (i = 0; i <= longitudIp; i++)
            {
                // El primer y ultimo caracter deben ser siempre un numero. Esto me cubre de que empiece
                // o termine por '.'
                if ((i == 0 || i == (longitudIp -1)) && !isdigit(ip[i]))
                {
                    printf("IP no empieza y termina en digito\n");
                    ipOk = 0;
                    break;
                }

                // Bajo esta condicion, se que termine de leer un octeto. Por lo que tengo que
                // validar la cantidad de puntos y el octeto leido.
                else if (ip[i] == '.' || ip[i] == '\0')
                {
                    octeto[posConversion] = '\0';
                    num = atoi(octeto);
                    cantPuntos++;

                    if (cantPuntos > 4 || num > 255)
                    {
                        printf("Cantidad de puntos excedido u octeto invalido\n");
                        ipOk = 0;
                        break;
                    }

                    posConversion = 0;
                }

                // Bajo esta condicion, me encontre que un caracter que no es ni punto
                // ni numero, por lo tanto, rechazo todo el string ingresado por el usuario.
                else if (!isdigit(ip[i]))
                {
                    printf("Algo de lo ingresado no es punto o digito\n");
                    ipOk = 0;
                    break;
                }

                // Bajo cualquier otra condicion, el caracter es valido y lo acumulo
                // hasta el proximo punto o fin de string para validarlo.
                else
                {
                    octeto[posConversion++] = ip[i];
                }
            }

            // Si al final, todo salio bien, valido la cantidad de octetos y defino si lo
            // acepto.
            if (cantPuntos > 4 && ipOk)
            {
                printf("Cantidad de puntos u octetos invalido\n");
                ipOk = 0;
                continue;
            }
        }
    }

    return ip;
}
