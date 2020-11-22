#include <stdio.h>

int diff_square(int a, int b){
	return a*a - b*b;
}

int main(){
	int a = 8;
	int b = 5;
	printf("%d\n",diff_square(a,b));

	return 0;
}