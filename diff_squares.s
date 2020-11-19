@calcolo di x^2-y^2

        .data

forms:  .string "Risultato=%d\n"
        .text
        .global main

main:   mov r1,#4
        mov r2,#7
        mul r1,r1,r1
        mul r2,r2,r2
        sub r0,r1,r2

print:  mov r1,r0
        ldr r0,=forms
        bl printf

end:    mov r7,#1
        mov r0,#0
        svc 0