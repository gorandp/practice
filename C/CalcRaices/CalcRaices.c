#include <stdio.h>
#include <stdlib.h>
#include <math.h>

struct complejo
{
    float real;
    float lateral;
};

typedef struct complejo COMPLEX;

int main()
{
    COMPLEX res[2];
    float a,b,c,resol;
    while(1)
    {
        printf("a = ");
        scanf("%f", &a);
        printf("b = ");
        scanf("%f", &b);
        printf("c = ");
        scanf("%f", &c);

        resol = b*b - 4*a*c;
        if(resol >= 0)
        {
            res[0].real = ( b*(-1) + sqrt(resol) ) / (2.0 * a);
            res[0].lateral = 0;
            res[1].real = ( b*(-1) - sqrt(resol) ) / (2.0 * a);
            res[1].lateral = 0;
        }
        else
        {
            resol *= -1;
            res[0].real =  -b / (2.0 * a);
            res[0].lateral = sqrt(resol) / (2.0 * a);
            res[1].real = -b / (2.0 * a);
            res[1].lateral = sqrt(resol) * (-1) / (2.0 * a);
        }

        printf("\nR1 = %.2f + %.2f i\t", res[0].real, res[0].lateral);
        printf("\tR2 = %.2f + %.2f i\n\n", res[1].real, res[1].lateral);
    }

    return 0;
}
