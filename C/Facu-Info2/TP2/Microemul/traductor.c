#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "traductor.h"
#include "cadenas.h"

#define AAC 160 //ascii letra "a" con acento
#define IAC 161 //ascii letra "i" con acento
#define OAC 162 //ascii letra "o" con acento

#define TINS 70 //cantidad maxima de instrucciones
#define TVAR 30 //cantidad maxima de variables
#define COP 13  //cantidad de operaciones

void Traductor(char* dir)
{
    FILE* pf;
    FILE* lf;
    int i, j, index=0; //index sirve para saber la cantidad de variables utilizadas
    char cad[128], auxOP[6], auxOD[3]; //auxOP = cad auxiliar para almacenar el cod. de op. //auxOD = cad. aux. para almac. el operando

    int codOp[COP] = {10, 11, 20, 21, 22, 30, 31, 32, 33, 40, 41, 42, 43};
    int dirVar[TVAR];
    char **var, **Op;

    //var
    var = (char **)malloc(sizeof(char*) * TVAR);
    for(i=0; i<TVAR; i++)
    {
        *(var + i) = (char *)malloc(sizeof(char) * 16); //Cada nombre de variable puede tener hasta 15 caracteres de letra
    }

    //Op
    Op = (char**)malloc(sizeof(char*) * COP);
    for(i = 0; i<COP; i++)
    {
        Op[i] = (char*)malloc(sizeof(char) * 6);
    }

    strcpy(Op[0], "READ");      strcpy(Op[1], "WRITE");                                                         //0-1   //I/O
    strcpy(Op[2], "LOAD");      strcpy(Op[3], "STORE");     strcpy(Op[4], "LDA");                               //2-4   //Carga/Almacenar
    strcpy(Op[5], "ADD");       strcpy(Op[6], "SUB");       strcpy(Op[7], "INC");       strcpy(Op[8], "DEC");   //5-8   //Op. Arit.
    strcpy(Op[9], "JMP");       strcpy(Op[10], "JN");       strcpy(Op[11], "JZ");       strcpy(Op[12], "HALT"); //9-12  //Op. Transf. C.


    //------- Comienzo de traduccion ---------//

    pf = fopen(dir,"r");
    lf = fopen("LMM.txt", "w");

    if((pf==NULL) || (lf==NULL))
	{
		printf("Error al abrir el archivo.\n");
		printf("No se ejecutar%c el emulador.\n", AAC);
        printf("Cerrando MICROEMUL. . .\n");
        fflush(stdin);
        getchar();
        exit(1);
	}
	else
	{
	    printf("===\n");
        while((fgets(cad, 127, pf)) != NULL)
        {
            printf("ORG %s", cad);

            if(getAux(cad, auxOP, auxOD) == 0) //Si es distinto a cero, significa que es un comentario, por lo que se descarta
            {
                for(j = 0; j < COP; j++)
                {
                    if(strcmp(Op[j], auxOP) == 0)
                    {
                        sprintf(auxOP, "%02d", codOp[j]);

                        switch(j)
                        {
                            case 4:     //OPERADOR LDA
                            case 7:     //OPERADOR INC
                            case 8:     //OPERADOR DEC
                            case 12:    //OPERADOR HALT
                                sprintf(auxOD, "%02d", 0);
                                break;

                            case 0:     //OPERADOR READ
                            case 1:     //OPERADOR WRITE
                            case 2:     //OPERADOR LOAD
                            case 3:     //OPERADOR STORE
                            case 5:     //OPERADOR ADD
                            case 6:     //OPERADOR SUB
                                if(*auxOD != '\0')
                                {
                                    for(i = 0; i < index; i++)
                                    {
                                        if(strcmp(var[i], auxOD) == 0)
                                        {
                                            sprintf(auxOD, "%02d", dirVar[i]);
                                            break;
                                        }
                                    }

                                    if((i == index) && (i < TVAR))
                                    {
                                        index++;
                                        dirVar[i] = TINS + i; //TINS es la posicion en memoria de la primer palabra variable
                                        strcpy(var[i], auxOD);
                                        sprintf(auxOD, "%02d", dirVar[i]);
                                    }
                                }
                                else
                                {
                                    printf("-> ERROR. VARIABLE NO DETECTADA. Reemplazado por la direcci%cn <99>\n", OAC);
                                    sprintf(auxOD, "%02d", 99);
                                }
                                break;

                            default: //OPERADORES JMP, JN, JZ
                                //El propio auxOD es el numero de linea, por lo que se lo deja asi
                                //aunque si es un numero de 1 digito y se lo escribe sin un cero a la izquierda, habria un problema, el siguiente codigo corrige eso
                                sprintf(auxOD, "%02d", CHARtoINT(auxOD));
                                break;
                        }

                        break;
                    }
                }

                if(j == COP)
                {
                    printf("-> ERROR. OPERADOR NO RECONOCIDO. Reemplazado por el operador <HALT>\n");
                    sprintf(auxOP, "%02d", codOp[12]);
                    sprintf(auxOD, "%02d", 0);
                }

                strcpy(cad+5, auxOP);   //Reemplazo con la cadena auxOP (cod. de operacion) a cad a partir del quinto caracter
                strcat(cad, auxOD);     //Concateno la cadena auxOD (operando) a cad

                fputs(cad, lf);
                fputc('\n', lf);
                printf("LML %s\n", cad);
                printf("===\n");
            }
            else
            {
                printf("LML Comentario no introducido en <LML.txt>\n");
                printf("===\n");
            }
        }


		if(fclose(pf)!=0 || fclose(lf)!=0){
			printf("Error al cerrar el archivo.\n");
			printf("No se ejecutar%c el emulador.\n", AAC);
			printf("Cerrando MICROEMUL. . .\n");
			fflush(stdin);
			getchar();
			exit(1);
		}
	}

	//-----------------------//
	//Liberado de memoria
	//var
    for(i=0; i<TVAR; i++)
    {
        free(*(var + i));
    }
    free(var);
    //Op
    for(i = 0; i<COP; i++)
    {
        free(Op[i]);
    }
    free(Op);
	//-----------------------//

    return;
}
