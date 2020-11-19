	.data

voti:	.word 18,30,27,26,20,30,30,28,-1	@ utilizzo un numero negativo per chiudere
fmt:	.string "La media (int) e' %d\n"

	.text
	.global main

main: 	mov r1, #0 		@ somma parziale
	mov r0, #0 		@ numero dei voti
	ldr r2, =voti		@ base dei voti in memoria
loop:	ldr r3, [r2], #4	@ carica un voto
	cmp r3, #0
	bmi finevoti		@ se e negativo fine voti
	add r1, r1, r3		@ aggiungilo alla somma
	add r0, r0, #1		@ a aggiorna il numero dei voti considerati fino ad ora
	b loop			@ e carica il prossimo (la base Ã¨ stata incrementata col postincr

finevoti:			@ va fatta un divisione che non 
	push {r5,r6}
	mov r5, #0
div:	cmp r1, r0
	blt fine
	sub r1, r1, r0
	add r5, r5, #1
	b div
fine:	ldr r0,=fmt
	mov r1, r5
	bl printf

exit:	mov r7, #1
	svc 0