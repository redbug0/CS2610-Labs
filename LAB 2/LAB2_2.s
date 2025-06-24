.data
a: .dword 0x1234567887654321, 0x1234567887654321
b: .dword 0x8765432112345678, 0x8765432112345678
result: .dword 0, 0, 0, 0

.text
.global main

main:


la a2, a
la a4, b

ld a1,0(a2)
ld a2,8(a2)
ld a3,0(a4)
ld a4,8(a4)

la a7, result

mul t0, a1, a3

sd t0, 0(a7)

mulhu t1, a1, a3
mul t2, a1, a4
mul t3, a2, a3

add t1, t1, t2
sltu t4, t1, t2

add t1, t1, t3
sltu t5, t1, t3

sd t1, 8(a7)

add t4, t4, t5

mulhu t0, a2, a3
mulhu t2, a1, a4
mul t3, a2, a4

add t4, t0, t4
sltu t6, t4, t0

add t4, t4, t2
sltu a6, t4, t2
add t6, t6, a6

add t4, t4, t3
sltu a6, t4, t3
add t6, t6, a6

sd t4, 16(a7)

mulhu a6, a2, a4
add a6, a6, t6

sd a6, 24(a7)


ret
