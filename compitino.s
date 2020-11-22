		.data
fmt: 	.string "Risultato = %d\n"
		.text
		.global main

main: 	


print: 	mov r1, r0
		ldr r0, =fmt
		bl printf

end: 	mov r7, #1
		mov r0, #0
		svc 0
		