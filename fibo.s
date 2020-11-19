		.data
fmt:
		.string "Risultato = %d\n"
		.text
		.global main

main:
		mov r0, #7
		bl fibo
		b print
		mov r7, #1
		mov r0, #0
		svc 0


print:
		mov r1, r0
		ldr r0, =fmt
		bl printf

end:
		mov r7, #1
		mov r0, #0
		svc 0
		
fibo:
		cmp r0, #0
		moveq PC, LR
		cmp r0, #1
		moveq PC, LR
		bne ric
		mov PC, LR

ric:
		sub r0,r0,#1
		push {r0, LR}
		sub r0,r0,#1
		push {r0, LR}
		bl fibo
		pop {r1, LR}
		pop {r2, LR}
		add r0,r1,r2
		mov PC, LR
		