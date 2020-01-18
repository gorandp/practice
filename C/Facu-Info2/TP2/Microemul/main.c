#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "traductor.h"
#include "emulador.h"
#include "cadenas.h"

#define AAC 160 //ascii letra "a" con acento
#define IAC 161 //ascii letra "i" con acento
#define OAC 162 //ascii letra "o" con acento

/*

Devoluciones funcion Emulador

0 = Emulador ejecutado correctamente.
1 = Error. Operacion no encontrada.
2 = Error en la carga del archivo "LMM.txt".
3 = Intento de guardado de entero mayor que 9999 o menor que -9999 en una palabra de memoria
4 = Desbordamiento del acumulador. Resultado de operacion aritmetica mayor a 9999 o menor a -9999

*/

int main()
{
    int emuOut;
    char *dirProg, *memDump;
    dirProg = (char*)malloc(sizeof(char)*256);

    printf("*** Bienvenido a MICROEMUL\t\t\t\t\t***\n");
    printf("*** Se buscar%c un archivo de nombre programa\t\t\t***\n", AAC);
    printf("*** y extensi%cn .txt .A continuaci%cn su programa\t\t***\n", OAC, OAC);
    printf("*** se imprimir%c en pantalla instrucci%cn por instrucci%cn\t***\n", AAC, OAC, OAC);
    printf("*** Comenzando por el numero de posici%cn seguido de\t\t***\n", OAC);
    printf("*** un signo de interrogaci%cn\t\t\t\t\t***\n\n", OAC);
    printf("Por ejemplo:\n\n");
    printf("#SUMA DE DOS ENTEROS\n00 ? READ A\n01 ? READ B\n02 ? LOAD A\n03 ? ADD B\n04 ? STORE C\n05 ? WRITE C\n06 ? HALT\n\n");

    printf("Ingrese la ruta donde se ubica su programa\n");
    printf("(por ejemplo: << C:\\Users\\MicroUser\\Desktop\\Programa.txt >>)\n");

    scanf("%s", dirProg);

    //TRADUCTOR ENSAMBLADOR A LMM
    system("cls");
    printf("Comenzando la lectura del archivo: %s\n", dirProg);

    Traductor(dirProg);

    free(dirProg);

	printf("Traducci%cn completa.\n", OAC);
	printf("El archivo con la traducci%cn se encuentra disponible en la carpeta ra%cz de este programa, con el nombre de <LMM.txt>\n", OAC, IAC);
	fflush(stdin);
	getchar();

	//EMULADOR
    system("cls");
    printf("---------------- MICROEMUL v1.0 ----------------\n");
    emuOut = Emulador(&memDump);
    printf("%s------------------------------------------------\n", memDump);
    if(emuOut == 0)
    {
        printf("Ejecuci%cn del programa finalizada exitosamente.\n", OAC);
    }
    else
    {
        printf("ERROR. Ejecuci%cn de Microemul terminada anormalmente.\nDescripci%cn del error: ", OAC, OAC);
        switch(emuOut)
        {
            case 1:
                printf("Operaci%cn no encontrada.\n", OAC);
                break;

            case 2:
                printf("Carga fallida del archivo <LMM.txt>.\n");
                break;

            case 3:
                printf("Desbordamiento de la palabra en memoria.\n");
                break;

            case 4:
                printf("Desbordamiento del acumulador.\n");
                break;

            default:
                printf("Desconocido.");
                break;
        }
    }

    free(memDump);
    printf("Cerrando MICROEMUL . . .\n");
    fflush(stdin);
    getchar();
    return 0;
}
