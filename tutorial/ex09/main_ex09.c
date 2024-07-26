// gcc -m64 ex09.o main_ex09.c -o ex09

#include <stdio.h>
#include "ex09.h"

int main(void) {
	int result;
	result = add42(0);
	printf("Result: %i\n", result);
	return 0;
}
