L=10
.global main

main: save %sp, -96, %sp
mov %g0, %o0 !s=0
mov 1, %l0 !i=1
loop: subcc %l0, L, %g0 !if i>10
bg next_r !루프 이탈
nop
add %o0, %l0, %o0 !s+=i
inc %l0 !i++
ba loop !후방 분기
nop
next_r: ret
restore

