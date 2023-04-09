	.global main
main:	save %sp, -96, %sp
	mov 5, %i0
	mov 2, %i1
	mov 3, %i2
	mov 1, %i3
	mov 4, %i4
	mov 2, %i5

	mov %i0, %o0
	mov %i1, %o1
	call .rem
	nop
	mov %o0, %l0
	sub %i2, %i3, %l1	
	add %l0, %l1, %l2
	add %i4, %i5, %l3
	mov %l2, %o0
	mov 12, %o1
	call .mul
	nop
	mov %o0, %l4
	mov %l4, %o0
	mov %l3, %o1
	call .div
	nop
	mov %o0, %i0
result:
	ret
	restore
	