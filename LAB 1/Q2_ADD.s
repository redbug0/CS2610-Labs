.data
a: .word 4
b: .word 3
result: .word 0

.text
.global main

main:

la a1, a
la a2, b

lw a1,0(a1)
lw a2,0(a2)

add t0, a1, a2

la a3, result
sw t0, 0(a3)

ret



