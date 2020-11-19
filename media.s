		.data
voti:	.word 18,30,27,26,20,30,30,28,-1
fmt:	.string "Risultato = %d\n"
		.text
		.global main

main:
		ldr r0, =voti @ Ho i voti in r0
		mov r1, #0
		mov r3, #0
		ldr r2, [r0], #4
		bl getvote    @ Alla fine dovrei avere in r0 la somma dei voti
					  @ in r1 niente di interessante e in r3 il numero dei voti
		mov r1, r3
		mov r2, #0
		bl divi
		
print:
		mov r1, r0
		ldr r0, =fmt
		bl printf

end:
		mov r7,#1
		mov r0, #0
		svc 0

getvote:
		cmp r2, #0
		movmi r0, r1
		movmi PC, LR 
		add r1, r1, r2
		add r3, r3, #1
		ldr r2, [r0], #4
		b getvote
				


divi:
		cmp r0, r1
		movlt r0, r2
		movlt PC, LR
		sub r0,r0,r1
		add r2, r2, #1
		b divi
		