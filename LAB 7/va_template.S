.section .text
.global main

.align 4
main:

    csrr t0, mstatus
    li t1, 0xFFFFEEFF
    and  t0, t0, t1
    li t1, 0x0800
    or t0, t0, t1
    csrrw zero, mstatus, t0
    la t0, supervisor
    csrrw zero, mepc, t0
    mret
    # Jump to supervisor mode

.align 4
supervisor:
    li t0, 0x81000000
    li t1, 0x00000082001
    slli t1, t1, 10
    ori t1, t1, 0x1
    sd t1, 0(t0)

    li t0, 0x82001000
    li t1, 0x00000083001
    slli t1, t1, 10
    ori t1, t1, 0x1
    sd t1, 0(t0)

    li t0, 0x83001000
    li t1, 0x00000080001
    slli t1, t1, 10
    ori t1, t1, 0x5b
    sd t1, 0(t0)

    li t0, 0x83001008
    li t1, 0x00000080002
    slli t1, t1, 10
    ori t1, t1, 0x57
    sd t1, 0(t0)

    li t0, 0x81000010
    li t1, 0x00000082000
    slli t1, t1, 10
    ori t1, t1, 0x1
    sd t1, 0(t0)

    li t0, 0x82000000
    li t1, 0x00000083000
    slli t1, t1, 10
    ori t1, t1, 0x1
    sd t1, 0(t0)

    li t0, 0x83000000
    li t1, 0x00000080000
    slli t1, t1, 10
    ori t1, t1, 0x4b
    sd t1, 0(t0)
    

################ Initialize your page tables here ################
    

####################################################################
    csrr t0, sstatus
    li t1, 0xFFFFFEFF
    and  t0, t0, t1
    csrrw zero, sstatus, t0
    # Prepare jump to user mode

################ DO NOT MODIFY THESE INSTRUCTIONS ################
    la t1, satp_config # load satp val
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero

    li t4, 0
    csrrw zero, sepc, t4
    sret
####################################################################


.align 12
user_code:
    la t1,var1
    la t2,var2
    la t3,var3
    la t4,var4
    j user_code


.data
.align 12
var1:  .word  1
var2:  .word  2
var3:  .word  3
var4:  .word  4

.align 8
satp_config: .dword 0x8000000000081000 # Value to set in satp