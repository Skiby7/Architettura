fmt:
		.text
		.string "Risultato = %d\n"
		.global main

main:
		mov r0, #1
		mov r1, #2
		mov r2, #4

loop:
		cmp r2, #0
		beq print
		mul r0,r0,r1
		sub r2, #1
		b loop
		
		


print:
		mov r1, r0
		ldr r0,=fmt
		bl printf

end:
		mov r7,#1
		mov r0,#0
		svc 0

