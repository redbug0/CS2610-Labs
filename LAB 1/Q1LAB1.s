.data
a: .word 5, 3, 4, 6, 5
result: .word

.text
.global main

main:

la a1, a
li t0, 0
li t5, 0
li t4, 20

ST:
    add t1, t0, a1;
    lw t2, 0(t1)
    beq t4, t0, END
    add t3, t5, t2
    addi t5, t5, 1
    addi t0, t0, 4
    sw t3, 0(t1)
    j ST

END:
    ret





