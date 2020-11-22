		.text
		.global quanto

quanto: mov r3, r0 @ copio r0 in r3
		mov r0, #0 @ metto 0 in r0 così da essere pronto a restituire 0 nel caso il carattere non fosse un numero
		sub r3, r3, #48 @ essendo 0 è il 48-esimo carattere nella tabella ascii
		cmp r3, #0 @ prima condizione
		bge next

next: 	cmp r3, #9 @ seconda condizione
		movle r0,r3		@ se le condizioni sono rispettate, restituisco il contenuto di r3
		mov PC, LR
		