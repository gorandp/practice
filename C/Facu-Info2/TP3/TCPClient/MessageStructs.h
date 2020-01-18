#ifndef MESSAGESTRUCTS_H_INCLUDED
#define MESSAGESTRUCTS_H_INCLUDED

#define SERVER_PORT             5050
#define MAX_NAME_LEN            20
#define MAX_MSG_LEN             1000


// IDs Mensajes Cliente-Servidor
#define DEFINIR_USUARIO         1
#define ENVIAR_MENSAJE          2
#define ENVIAR_LOOPBACK         3
#define DESHAB_RETORNO_MENSAJE  4
#define HAB_RETORNO_MENSAJE     5


// IDs Mensajes Servidor-Cliente
#define MENSAJE_OK              20
#define MENSAJE_ERROR           21
#define NUEVO_MENSAJE           22
//#define CONNECT_OK              23


// Estructuras
struct mensaje
{
    int idMensaje;
    char mensaje[MAX_MSG_LEN];
};

#endif // MESSAGESTRUCTS_H_INCLUDED
