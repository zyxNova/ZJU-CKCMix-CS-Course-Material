#include <stdio.h>
#include"input.h"
double input(char *s)
{
	float x;
	printf("%s", s);
	scanf("%f", &x);
	return (x);
}
