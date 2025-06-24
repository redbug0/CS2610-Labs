.section .text
.global main
main:
    li t6, 10000
    li t5, 0
    li t2, 0x2004000
    sw t6, 0(t2)

    csrr t0, mstatus
    li t1, 0xFFFFEEFF
    and  t0, t0, t1
    csrrw zero, mstatus, t0

    csrr t1, mie
    ori t1, t1, 0x80
    csrrw zero, mie, t1

    la t0, mtrap
    csrw mtvec, t0
    la t0, user
    csrrw zero, mepc, t0

mtrap:
    li t0, 0x2004000
    lw t1, 0(t0)
    li t3, 10000
    add t1, t1, t3
    sw t1, 0(t0)

    csrr t4, mcause
user:
    li t1, 0
    li t2, 1
    add t1, t1, t2
    li t0, 0x2004000
    lw t3, 0(t0)
    li t0, 0x200bff8
    lw t4, 0(t0)
    j user


