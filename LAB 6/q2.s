.data
.align 4
stack_a:  .dword  0xffff0000 # initialize stack for task A (You can choose a random address) 
stack_b:  .dword  0xffff1000 # initialize stack for task B
current:  .word  0x0 # variable to identify the task 
flag: .word 0x0

.section .text
.global main
.align 4
main:
	li t2, 10000
    li t0,0		

    li t1, 0x2004000
    sw t2, 0(t1)	

	li t3, 0x0FFFFFFF
	li t4, 0x03FFFFFF

    csrr t0, mstatus

    li t1, 0xFFFFEEFF
    and t0, t0, t1        
    csrrw zero, mstatus,t0 

    csrr t1,mie
    ori t1, t1, 0x80        
    csrrw zero, mie, t1

    la t0, context_switch  
    csrrw zero, mtvec,t0     

    la t0, Task_A
    csrrw zero, mepc,t0 

	mret
		# Enable interrupts

		# configure timer interrupt 
		# set the value of mtimecmp register
.align 4
context_switch:
	li t0, 1
	la t2, current
	lw t2, 0(t2)

	beq t0,t2, switch_to_A
	li t0, 1
	la t2, flag
	lw t2, 0(t2)
	beq t0,t2, switch_to_B
	j initial_switch_to_B
		# save the context of the interrupted task by looking at the task id (jump to relavent label)

.align 4
save_context_A:
	la t0, stack_a
	lwu sp, 0(t0)

	addi sp,sp, -16
	sw t1, 0(sp)
	csrr t2, mepc
	sw t2, 8(sp)
	
	sw sp, 0(t0)
	ret
		# save all the registers and PC value in stack_a
		# mepc stores the value of PC at the time of interrupt
.align 4
save_context_B:
	la t0, stack_b
	lwu sp, 0(t0)

	addi sp,sp, -16
	sw t1, 0(sp)
	csrr t2, mepc
	sw t2, 8(sp)

	sw sp, 0(t0)
	ret
		# save all the registers and PC value in stack_b
.align 4
switch_to_A:
	jal save_context_B

	la t0, stack_a
	lwu sp, 0(t0)

	lw t1,0(sp)
	lwu t2, 8(sp)
	csrw mepc, t2

	addi sp,sp,8

	li t6, 0
	la t5, current
	sw t6, 0(t5)

	sw sp, 0(t0)

	j switch
		# restore the values of registers and PC from stack_a
.align 4
switch_to_B:
	jal save_context_A

	la t0, stack_b
	lwu sp, 0(t0)

	lw t1,0(sp)
	lwu t2, 8(sp)
	csrw mepc, t2
	addi sp,sp,8

	li t6, 1
	la t5, current
	sw t6, 0(t5)

	sw sp, 0(t0)
	j switch

		# restore the values of registers and PC from stack_b
.align 4
initial_switch_to_B:
	jal save_context_A

	mv t1, t4
	la t0, Task_B
	csrw mepc, t0
	li t6, 1
	la t5, current
	sw t6, 0(t5)

	li t0, 1
	la t2, flag
	sw t0, 0(t2)

	# la t0, context_switch
	# csrw mtvec, t0
	j switch
		# switching to Task B for the first time
.align 4
switch:
	li t0, 0x2004000
    lw t2, 0(t0)
    li t6, 10000
    add t2,t2,t6
    sw t2,0(t0)
	mret
		# set the value of mtimecmp and switch to your preferred task
.align 4
Task_A:
	addi t1, t1, 1
	bne t1,t3, Task_A
	# increment your reg value
.align 4
finish_a:
    j finish_a
.align 4
Task_B:
	addi t1,t1,-1
	bnez t1,Task_B
		# decrement the reg value
.align 4	
finish_b:
    j finish_b
