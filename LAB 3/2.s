.section .data
move: .ascii "move "
from: .ascii "from"
to: .ascii "to"
X: .ascii " X "
Y: .ascii " Y "
Z: .ascii " Z "
newline_char: .ascii "\n"
n: .byte 0x5

.global main
.section .text

main:
    addi sp, sp, -24
    sd ra, 16(sp)
    sd s0, 8(sp)
    addi s0, sp, 24

    la a0, X
    la a1, Y
    la a2, Z
    la a3, n
    lbu a3, 0(a3)
    jal ra, hanoi

    ld ra, 16(sp)
    ld s0, 8(sp)
    addi sp, sp, 24
    ret


hanoi:
    addi sp, sp, -48
    sd ra, 40(sp)
    sd s0, 32(sp)
    addi s0, sp, 48

    sd a0, 24(sp)
    sd a1, 16(sp)
    sd a2, 8(sp)
    sd a3, 0(sp)

    li t1, 1
    beq a3, t1, base_case
    j recursive_step

base_case:
    ld a4, 24(sp)
    ld a5, 8(sp)
    jal ra, print
    j finish

recursive_step:
    ld a0, 24(sp)
    ld a1, 8(sp)
    ld a2, 16(sp)
    ld a3, 0(sp)
    addi a3, a3, -1
    jal ra, hanoi

    ld a4, 24(sp)
    ld a5, 8(sp)
    jal ra, print

    ld a0, 16(sp)
    ld a1, 24(sp)
    ld a2, 8(sp)
    ld a3, 0(sp)
    addi a3, a3, -1
    jal ra, hanoi

finish:
    ld ra, 40(sp)
    ld s0, 32(sp)
    addi sp, sp, 48
    ret

print:
    li a0, 1
    la a1, move
    li a2, 5
    li a7, 64
    ecall

    li a0, 1
    la a1, from
    li a2, 4
    li a7, 64
    ecall

    li a0, 1
    mv a1, a4
    li a2, 3
    li a7, 64
    ecall

    li a0, 1
    la a1, to
    li a2, 2
    li a7, 64
    ecall

    li a0, 1
    mv a1, a5
    li a2, 3
    li a7, 64
    ecall

    li a0, 1
    la a1, newline_char
    li a2, 1
    li a7, 64
    ecall
    ret

