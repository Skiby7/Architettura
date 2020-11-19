		.data
x:  	.word 1,2,3,4
y:  	.word 5,6,7,8
n:  	.word 4

fmt: 	.string "Risultato = %d\n"
		.text
		.global main

main: 	
		ldr r0, =x
		ldr r1, =y
		ldr r2, =n
		ldr r2, [r2], #4
		mov r3, #1
		b pusho
exit:	mov r2, #1
		mov r0, #0
		sub r3, r3, #1
		bl ip
print: 	mov r1, r0
		ldr r0, =fmt
		bl printf
end: 	mov r7, #1
		mov r0, #0
		svc 0
		
		

pusho: 	cmp r3, r2
		bgt exit		
		ldr r5, [r0], #4
		ldr r6, [r1], #4
		push {r5,r6}
		add r3, r3, #1
		b pusho

ip: 	cmp r2, r3 
		movgt PC, LR
		pop {r5, r6}
		mul r1, r5, r6
		add r0, r0, r1
		add r2, r2, #1
		b ip
		
		
		