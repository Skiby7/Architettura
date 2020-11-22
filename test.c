#include <stdio.h>
#include <string.h>

/*
int quanto (char s){
        int c = s - '0';
        if (c >= 0 && c <= 9)
                return c;
        return 0;
}

int somma(char *s){
        int sum = 0;
        int i = 0;
        int n = strlen(s);
        while(i < n){
                sum += quanto(s[i]);
                i++;
        }
        return sum;

}
*/
extern int quanto(char);
extern int somma(char *);
int main() {
char * s = "ab1c234d56e7f8g9a";
int c = somma(s);
if(c == 45)
printf("Corretto\n");
else
printf("Sbagliato\n");
return 0;
}