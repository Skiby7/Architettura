		.data
		.text
        .global somma
		.type somma %function
		
somma: 	push {r0} @ salvo r0	
		push {LR} @ salvo LR prima della chiamata di strlen
		bl strlen 
		pop {LR} @ ripristino LR
		mov r2, r0 @sposto in r2 la lunghezza della stringa
		pop {r0} @ ripristino in r0 l indirizzo della stringa
		mov r1, #0 @ pulisco r1
		mov r3, #0 @ pulisco r3
		mov r6, #0 @ pulisco r6 che mi servirà dopo

		@ La funzione pusho serve a salvare tutti i caratteri della stringa nello stack
		
pusho: 	cmp r3, r2 @ guardia del while(i < n) con r2 = n = strlen(string) e r3 = i
		movge r3, #0 @ reset dei registri che mi servono dopo per la somma
		movge r4, #0 @ r3 lo uso nella funzine quanto e r4 nel while successivo
		bge sum @ mi sposto su somma
		ldrb r5, [r0], #1 @ carico il carattere in r5 e lo salvo nello stack
		push {r5}
		add r3, r3, #1 
		b pusho

sum:  	cmp r4, r2
        bge fine
        pop {r0} @ prelevo il carattere dallo stack
        push {LR} @ salvo LR
        bl quanto @ controllo se è un numero
        pop {LR} @ ripristino LR
        add r6, r6, r0 @ uso r6 per salvare la somma dei numeri
        add r4, r4, #1
        b sum

fine:	mov r0, r6 @ sposto il risultato su r0 
		mov PC, LR @ ritorno al main.c
	

