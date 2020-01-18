#ifndef EMULADOR_H_INCLUDED
#define EMULADOR_H_INCLUDED

void MemoryDump(int* memoria, int ACC, int PC, int IR, int OP, int OD, char** memDump);
int CargaMem(int* mem);
int Emulador();

#endif // EMULADOR_H_INCLUDED
