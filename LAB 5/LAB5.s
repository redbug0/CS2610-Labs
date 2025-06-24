.section .text
.global main
.align 4
main:
    csrr t0, mstatus
    li t1, 0xFFFFEEFF
    and  t0, t0, t1
    li t1, 0x0800
    li t1, 0x0800
    or t0, t0, t1
    csrrw zero, mstatus, t0

    csrr t1, medeleg
    li t0, 0x100
    or t1, t1, t0
    csrrw zero, medeleg, t1


    la t0, mtrap_handler 
    csrrw zero, mtvec, t0

    la t0, scode
    csrrw zero, mepc, t0

    mret
mtrap_handler:
    csrr t3, mepc
    csrr t4, mcause
    csrr t5, mtvec
    csrr t6, mstatus
    
    csrr t0, mepc
    addi t0, t0, 4
    csrrw zero, mepc, t0

    
    mret
scode:
    csrr t0, sstatus
    li t1, 0xFFFFE7FF
    and t0, t0, t1
    csrrw zero, sstatus, t0

    la t0, strap_handler
    csrrw zero, stvec, t0

    la t0, ucode
    csrrw zero, sepc, t0

    sret
strap_handler:
    csrr a1, sepc
    csrr a2, scause
    csrr a3, stvec


    ecall
    la t0, ucode
    csrrw zero, sepc, t0
    sret
ucode:
    li t0, 1
    ecall