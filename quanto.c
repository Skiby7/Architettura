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
	while(i > n){
		sum += quanto(s[i]);
		i++;
	}
	return sum;
	
}