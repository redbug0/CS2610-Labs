.data
result: .asciz "        "

.text
.global reverse
.global result

reverse:
addi sp,sp,-8
sw ra, 0(sp)


mv t5, a0
mv t1, a0
la t3, result
li t2, 0

loop:
    lb t4, 0(t1)
    beqz t4, loop_rev
    addi t2, t2, 1
    addi t1, t1, 1
    j loop

loop_rev:
    addi t1, t1, -1
    lb t6, 0(t1)
    sb t6, 0(t3)
    addi t3, t3, 1
    beq t5, t1, END_rev
    j loop_rev

END_rev:
li a3, 0
sb a3, 0(t3)
addi a0, t2, 0

lw ra, 0(sp)
addi sp, sp, 8
ret



