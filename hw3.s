.text
.global main
main:
	save %sp, -96, %sp
	
	set str1, %o0
	call printf
	nop
	
	set str2, %o0
	set val, %o1
	call scanf
	nop
	
	set val, %l0
	ld[%l0], %l0

	set str1, %o0
	call printf
	nop
	
	set str2, %o0
	set val, %o1
	call scanf
	nop
	
	set val, %l1
	ld[%l1], %l1

	subcc %l0, %l1, %g0
	be done
	nop

loop:	subcc %l0, %l1, %g0
	bl swap
	nop
	mov %l1, %l2
	mov %l0, %o0
	mov %l1, %o1
	call .rem
	nop
	mov %o0, %l1
	mov %l2, %l0
	subcc %l1, 0, %g0
	be done
	nop
	ba loop
	nop

swap:	mov %l1, %l3
	mov %l0, %l1
	mov %l3, %l0
	ba loop
	nop


done: 
	set str3, %o0
	mov %l0, %o1 
	call printf
	nop
	ret
	restore

.data
str1: .asciz "Value?> "
str2: .asciz "%d"
str3: .asciz "GCD is %d\n"
.align 4
val: .word 0