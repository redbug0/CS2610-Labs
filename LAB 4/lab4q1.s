.global course_name
.data
first_name: .asciz "Rithika"
last_name: .asciz "Ayyalapu"

.text
.global main

main:

la t1, course_name
li t2, 67
sb t2,0(t1)
li t2, 79
sb t2, 1(t1)
li t2, 97
sb t2, 2(t1)

jal getCourse
addi a2, a0, 0

la a0, first_name
la a1, last_name

jal displayStudentProfile

li a7,93

ecall
