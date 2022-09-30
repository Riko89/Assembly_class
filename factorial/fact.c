#include <stdio.h>

void factorial(int x);
int main(void) {
	int num = 0;
	printf("Enter a number to get it's factorial: ");
	scanf("%d", &num);
	factorial(num);
	return 0;
}