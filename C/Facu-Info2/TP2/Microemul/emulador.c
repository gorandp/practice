#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "emulador.h"
#include "cadenas.h"

int Emulador(char ** memDump)
{
    int ACC=0, PC=0, IR=0, OP=0, OD=0; //ACC = Acumulador; PC = Program Counter; IR = Instruction Reg.; OP = Cod. Op; OD = Operando;
    int *memoria;
    memoria = (int*)malloc(sizeof(int) * 100);

    //------- Comienzo de emulador ---------//

    //CARGA DE DATOS
    if(CargaMem(memoria) != 0) //Si CargaMem() no devuelve 0, quiere decir que hubo un error en la carga de datos
    {
        free(memoria);
        return 2;
    }

    //EJECUCION
    PC = 0;
    do
    {
        //1
        IR = memoria[PC];
        //2
        OD = IR%100;
        OP = (IR - OD)/100;
        //3
        PC++;
        //4 -> 5
        switch(OP)
        {
            case 10:    //READ lee del teclado y guarda en la direccion OD de la memoria
                printf("INPUT: ");
                scanf("%d",memoria+OD);
                if((memoria[OD] < -9999)||(memoria[OD] > 9999))
                {
                    MemoryDump(memoria, ACC, PC, IR, OP, OD, memDump);
                    free(memoria);
                    return 3;
                }
                break;

            case 11:    //WRITE imprime en pantalla lo que haya en la direccion OD de la memoria
                printf("OUTPUT: %d\n", *(memoria+OD));
                break;

            case 20:    //LOAD carga lo que haya en la dir OD de la memoria en ACC
                ACC = memoria[OD];
                break;

            case 21:    //STORE almacena lo que haya en ACC en la dir OD de la memoria
                memoria[OD] = ACC;
                break;

            case 22:    //LDA carga ACC con lo que haya en la palabra siguiente a la instruccion actual
                ACC = memoria[PC+1];
                break;

            case 30:    //ADD suma ACC con lo que haya en la dir OD de la memoria, el resultado se guarda en ACC
                ACC += memoria[OD];
                if((ACC < -9999)||(ACC > 9999))
                {
                    MemoryDump(memoria, ACC, PC, IR, OP, OD, memDump);
                    free(memoria);
                    return 4;
                }
                break;

            case 31:    //SUB resta ACC con lo que haya en la dir OD de la memoria, el resultado se guarda en ACC
                ACC -= memoria[OD];
                if((ACC < -9999)||(ACC > 9999))
                {
                    MemoryDump(memoria, ACC, PC, IR, OP, OD, memDump);
                    free(memoria);
                    return 4;
                }
                break;

            case 32:    //INC ACC++
                ACC++;
                if((ACC < -9999)||(ACC > 9999))
                {
                    MemoryDump(memoria, ACC, PC, IR, OP, OD, memDump);
                    free(memoria);
                    return 4;
                }
                break;

            case 33:    //DEC ACC--
                ACC--;
                if((ACC < -9999)||(ACC > 9999))
                {
                    MemoryDump(memoria, ACC, PC, IR, OP, OD, memDump);
                    free(memoria);
                    return 4;
                }
                break;

            case 40:    //JMP "PC = OD"
                PC = OD;
                break;

            case 41:    //JN si "ACC < 0" entonces "PC = OD"
                if(ACC < 0) PC = OD;
                break;

            case 42:    //JZ si "ACC == 0" entonces "PC = OD"
                if(ACC == 0) PC = OD;
                break;

            case 43:    //HALT se detiene el emulador
                break;

            default: //Operacion no existente
                MemoryDump(memoria, ACC, PC, IR, OP, OD, memDump);
                free(memoria);
                return 1;
                break;
        }
    //6
    }while(OP != 43); //Si OP es HALT entonces sale del bucle

    MemoryDump(memoria, ACC, PC, IR, OP, OD, memDump);
    free(memoria);
    return 0;
}

int CargaMem(int* mem)
{
    FILE* lf;
    char cad[128], auxPAL[5], aux[1]; //aux carece de importancia y utilidad, solo se utiliza para completar los parametro requeridos por getAux
    int i=0;

    //------- Comienzo de lectura ---------//

    lf = fopen("LMM.txt", "r");

    if(lf == NULL)
	{
	    return 1;
	}
	else
	{
        while((fgets(cad, 127, lf)) != NULL)
        {
            getAux(cad, auxPAL, aux);
            mem[i] = CHARtoINT(auxPAL);
            i++;
        }

        if(fclose(lf)!=0)
        {
			return 1;
		}
	}

	return 0;
}

void MemoryDump(int* memoria, int ACC, int PC, int IR, int OP, int OD, char** memDump)
{
    int i;
    char aux[100], *texto;
    *memDump = (char*)malloc(sizeof(char) * 4000);
    texto = *memDump;

    sprintf(texto, "\n------\nMemory\nDump\n------\n\n");

    strcat(texto, "=REGISTROS=\n");
    sprintf(aux, "ACC\t%d\n", ACC);
    strcat(texto, aux);
    sprintf(aux, "PC\t%02d\n", PC);
    strcat(texto, aux);
    sprintf(aux, "IR\t%d\n", IR);
    strcat(texto, aux);
    sprintf(aux, "OP\t%02d\n", OP);
    strcat(texto, aux);
    sprintf(aux, "OD\t%02d\n\n", OD);
    strcat(texto, aux);

    strcat(texto, "=MEMORIA=\n");
    for(i = 0; i < 10; i++)
    {
        sprintf(aux, "\t%4d", i);
        strcat(texto, aux);
    }

    for(i = 0; i < 100; i++)
    {
        if(i%10 == 0)
        {
            sprintf(aux, "\n%02d\t", i);
            strcat(texto, aux);
        }

        sprintf(aux, "%04d\t", memoria[i]%10000);
        strcat(texto, aux);
    }
    strcat(texto, "\n\n");

    return;
}
