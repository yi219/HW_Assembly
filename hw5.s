/*	R=3
	C=4
	
	.data
arr:	.word 1,2,3,4
	.word 5,6,7,8
	.word 9,10,11,12

	R=7
	C=8

	.data
arr: 	.word 11,12,13,14,15,16,17,18
	.word 21,22,23,24,25,26,27,28
	.word 31,32,33,34,35,36,37,38
	.word 41,42,43,44,45,46,47,48
	.word 51,52,53,54,55,56,57,58
	.word 61,62,63,64,65,66,67,68
	.word 71,72,73,74,75,76,77,78

str0: .asciz "%3d"
str1: .asciz "\n"
str2: .asciz "Before:\n"
str3: .asciz "After:\n"*/
.align 4

	.text
	var = -12

	.global main
main: 	save %sp, -96, %sp
	set arr, %l2 	!배열 시작 주소

	set str2, %o0
	call printf
	nop
	call print_arr
	nop
	set str3, %o0
	call printf
	nop
	call rotate_arr
	nop
	call print_arr
	nop
	
	ret
	restore


print_arr:	save %sp, -96, %sp
	set arr, %l2 	!배열 시작 주소
	mov 0, %l0
	ba for_i
	nop

inner:	mov %l0, %o0
	mov C, %o1
	call .mul
	nop
	mov %o0, %l3 	! %l3 = (i*C)
	add %l3, %l1, %l3	! %l3 = (i*C)+j
	sll %l3, 2, %l3	! %l3 = ((i*C)+j)*4
	
	set str0, %o0
	ld [%l2+%l3], %o1
	call printf
	nop

	add %l1, 1, %l1	! j++

for_j:	cmp %l1, C
	bl inner
	nop
	set str1, %o0
	call printf
	nop

	add %l0, 1, %l0

for_i:	cmp %l0, R
	bl for_j
	mov 0, %l1
	
	set str1, %o0
	call printf
	nop

	ret
	restore

rotate_arr:	save %sp, -104, %sp
	set arr, %l2 
	mov 0, %l0	! %l0 : rmin = 0 
	mov R, %l1
	sub %l1, 1, %l1	! % l1 : rmax = R-1 
	mov 0, %l3	! % l3 : cmin = 0
	mov C, %l4
	sub %l4, 1, %l4	! %l4 : cmax = C-1

while:	cmp %l0, %l1
	bge done
	nop
	cmp %l3, %l4
	bge done
	nop

	add %l0, 1, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %l3, %o0
	sll %o0, 2, %o0
	ld [%l2+%o0], %l6
	st %l6, [%fp+var+4] 	! %l6 : prev = arr[rmin+1][cmin]
	
	st %l3, [%fp+var]	! i = cmin
	ld [%fp+var], %l5	! %l5 = i
	cmp %l5, %l4
	bl for_cmin
	nop
 for_cmin:	mov %l0, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %l5, %o0
	sll %o0, 2, %o0
	ld [%l2+%o0], %l7	
	st %l7, [%fp+var+8]	! %l7 : curr = arr[rmin][i]
	ld [%fp+var+4], %o1
	st %o1, [%l2+%o0]	! arr[rmin][i] = prev
	st %l7, [%fp+var+4] 	! prev = curr
	add %l5, 1, %l5
	cmp %l5, %l4
	bl for_cmin
	nop

	st %l0, [%fp+var]	! i = rmin
	ld [%fp+var], %l5	! %l5 = i
	cmp %l5, %l1
	bl for_rmin
	nop
 for_rmin: 	mov %l5, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %l4, %o0
	sll %o0, 2, %o0
	ld [%l2+%o0], %l7	
	st %l7, [%fp+var+8]	! %l7 : curr = arr[i][cmax]
	ld [%fp+var+4], %o1
	st %o1, [%l2+%o0]	! arr[i][cmax] = prev
	st %l7, [%fp+var+4] 	! prev = curr
	add %l5, 1, %l5
	cmp %l5, %l1
	bl for_rmin
	nop

	st %l4, [%fp+var]	! i = cmax
	ld [%fp+var], %l5	! %l5 = i
	cmp %l5, %l3
	bg for_cmax
	nop
 for_cmax:	mov %l1, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %l5, %o0
	sll %o0, 2, %o0
	ld [%l2+%o0], %l7	
	st %l7, [%fp+var+8]	! %l7 : curr = arr[rmax][i]
	ld [%fp+var+4], %o1
	st %o1, [%l2+%o0]	! arr[rmax][i] = prev
	st %l7, [%fp+var+4] 	! prev = curr
	sub %l5, 1, %l5
	cmp %l5, %l3
	bg for_cmax
	nop

	st %l1, [%fp+var]	! i = rmax
	ld [%fp+var], %l5	! %l5 = i
	cmp %l5, %l0
	bg for_rmax
	nop
 for_rmax: 	mov %l5, %o0
	mov C, %o1
	call .mul
	nop
	add %o0, %l3, %o0
	sll %o0, 2, %o0
	ld [%l2+%o0], %l7	
	st %l7, [%fp+var+8]	! %l7 : curr = arr[i][cmin]
	ld [%fp+var+4], %o1
	st %o1, [%l2+%o0]	! arr[i][cmin] = prev
	st %l7, [%fp+var+4] 	! prev = curr
	sub %l5, 1, %l5
	cmp %l5, %l0
	bg for_rmax
	nop

	add %l0, 1, %l0
	sub %l1, 1, %l1
	add %l3, 1, %l3
	sub %l4, 1, %l4

	ba while
	nop	

done:	ret
	restore