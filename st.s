 .data
hello: .string "Hello"

    .text
    .global main

main:   ldr r0, =hello
    bl strlen
    mov r2, #0    

loop2:   cmp r3, r1
    movge r3, r0
    movge PC,LR
    pop {r1}
   
    add r2, r2, r0
    add r3, r3, #1
    b loop2

