		.data
fmt: 	.string "Risultato = %d\n"
		.text
        .global somma
		.type somma %function
		
somma: 	push {r0}	
		push {LR}
		bl strlen 
		pop {LR}
		mov r2, r0 @sposto in r2 la len max
		pop {r0}
		mov r1, #0 @pulisco r1
		mov r3, #0 @init r3
		mov r6, #0 @init r6 for later use

pusho: 	cmp r3, r2 @r2 variabile di controllo, r3 variabile di iterazione
		movge r3, #0 @ reset dei registri che mi servono dopo per la somma
		movge r4, #0
		bge sum @ mi sposto su somma
		ldrb r5, [r0], #1
		push {r5}
		add r3, r3, #1
		b pusho

sum:  	cmp r4, r2
        bge fine
        pop {r5}
        mov r0, r5
        bl quanto
        add r6, r6, r0
        add r4, r4, #1
        b sum

fine: 	@mov r1, r6
		@push {r6}
		@ldr r0, =fmt
		@bl printf
		@pop {r0}
		mov r0, r6
		mov r7, #1
		mov PC, LR

