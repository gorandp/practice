#include <stdlib.h>
#include <string.h>
#include "cadenas.h"

int getAux(char* cad, char* auxOP, char* auxOD)
{
    while((*cad != '\0')&&(*cad != '?')) //Recorre cad hasta encontrarse el caracter '?'
    {
        if(*cad == '#') return (-1); //Es un comentario, devuelve -1
        cad++;
    }

    do
    {
        cad++;
    }while((*cad != '\0')&&( (*cad == ' ')||(*cad == '\t') )); //Recorre cad hasta encontrarse con un caracter distinto del espacio o tab

    //Codigo Operacion
    while((*cad != '\n')&&(*cad != '\0')&&(*cad != ' ')&&(*cad != '\t'))
    {
        *auxOP = *cad;
        auxOP++; cad++;
    }
    *(auxOP++) = '\0';

    while((*cad != '\0')&&( (*cad == ' ')||(*cad == '\t') )) cad++; //Recorre cad hasta encontrarse con un caracter distinto del espacio o tab

    //Operando
    while((*cad != '\n')&&(*cad != '\0')&&(*cad != ' ')&&(*cad != '\t')&&(*cad != '#'))
    {
        *auxOD = *cad;
        auxOD++; cad++;
    }
    *(auxOD++) = '\0';

    return 0;
}

int CHARtoINT(char* p) //En la cadena SOLAMENTE pueden estar los caracteres de los numeros y al final el caracter '\0'
{
    int res = 0;

    while(*p != '\0')
    {
        res *= 10;
        res = res + (*p - '0');
        p++;
    }

    return res;
}
