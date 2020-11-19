	.arch armv7-a
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"prova.c"
	.text
	.align	1
	.global	diff_square
	.arch armv7-a
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	diff_square, %function
diff_square:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #12
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	ldr	r3, [r7, #4]
	mul	r2, r3, r3
	ldr	r3, [r7]
	mul	r3, r3, r3
	subs	r3, r2, r3
	mov	r0, r3
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	ldr	r7, [sp], #4
	bx	lr
	.size	diff_square, .-diff_square
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\012\000"
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #8
	add	r7, sp, #0
	movs	r3, #8
	str	r3, [r7]
	movs	r3, #5
	str	r3, [r7, #4]
	ldr	r1, [r7, #4]
	ldr	r0, [r7]
	bl	diff_square(PLT)
	mov	r3, r0
	mov	r1, r3
	ldr	r3, .L5
.LPIC0:
	add	r3, pc
	mov	r0, r3
	bl	printf(PLT)
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #8
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L6:
	.align	2
.L5:
	.word	.LC0-(.LPIC0+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",%progbits
