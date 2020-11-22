		
		.text
		.global somma

somma: 	bl strlen
		mov r2, #0		

loop2: 	cmp r3, r1
		movge r3, r0
		movge PC,LR
		pop {r1}
		bl quanto
		add r2, r2, r0
		add r3, r3, #1
		b loop2

loop1: 	cmp r0, #0
		moveq PC, LR
		ldr r0, [r0], #4
		push {r0}
		add r3, r3, #1
		b strlen
		
		