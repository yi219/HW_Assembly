.text
nums_s = -20

.global main
main:
	save %sp, -112, %sp
	
	set str1, %o0
	call printf
	nop
	
	set str2, %o0
	set val, %o1
	call scanf
	nop
	
	set val, %l0
	ld[%l0], %l0

	cmp %l0, 0
	be case_0
	nop
	cmp %l0, 1
	be case_1
	nop

case_0: mov 10, %o0
	st %o0, [%fp+nums_s]
	mov 20, %o0
	st %o0, [%fp+nums_s+4]
	mov 30, %o0
	st %o0, [%fp+nums_s+8]
	mov 40, %o0
	st %o0, [%fp+nums_s+12]
	mov 50, %o0
	st %o0, [%fp+nums_s+16]

	mov 5, %l3
	ld [%fp + nums_s], %l1
	ld [%fp + nums_s], %l2

	ba fortest
	mov 1, %l0
	
case_1: mov 0, %l4
	mov 5, %l3

	call time
	mov 0, %o0
	call srand
	nop

for_1:	call rand
	nop
	mov 100, %o1
	call .rem
	nop
	sll %l4, 2, %o3
	add %fp, %o3, %o3
	st %o0,  [%o3 + nums_s]
	add %l4, 1, %l4

f_test:	cmp %l4, %l3
	bl for_1
	nop

	mov 5, %l3
	ld [%fp + nums_s], %l1
	ld [%fp + nums_s], %l2

	ba fortest
	mov 1, %l0
	

for: 	sll %l0, 2, %o0	
	add %fp, %o0, %o0
	ld [%o0 + nums_s], %o0

	cmp %l2, %o0
	bge nochange
	nop
	mov %o0, %l2
	
nochange: inc %l0
	
fortest:cmp %l0, %l3
	bl for
	nop
	
	set arr, %o0
	ld [%fp+nums_s], %o1
	ld [%fp+nums_s+4], %o2
	ld [%fp+nums_s+8], %o3
	ld [%fp+nums_s+12], %o4
	ld [%fp+nums_s+16], %o5
	call printf
	nop

	set max_p, %o0
	mov %l2, %o1
	call printf
	nop

	ba min_test
	mov 1, %l0

min_for: sll %l0, 2, %o0	
	add %fp, %o0, %o0
	ld [%o0 + nums_s], %o0

	cmp %o0, %l1
	bge min_noch
	nop
	mov %o0, %l1
	
min_noch: inc %l0
	
min_test:cmp %l0, %l3
	bl min_for
	nop
	
	set min_p, %o0
	mov %l1, %o1
	call printf
	nop
	
	ret
	restore



.data
str1: .asciz "Value?> "
str2: .asciz "%d"
arr: .asciz "{%d, %d, %d, %d, %d}\n"
max_p: .asciz "Max: %d\n"
min_p: .asciz "Min: %d\n"
.align 4
val: .word 0
