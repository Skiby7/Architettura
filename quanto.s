		.text
		.global quanto

quanto: mov r3, r0
		mov r0, #0
		sub r3, r3, #48
		cmp r3, #0
		bge next

next: 	cmp r3, #9
		movle r0,r3		
		mov PC, LR
		