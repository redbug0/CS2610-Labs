    .data
n:      .dword 6             
lsp:    .dword 0x7fffffffffffffff
hsp:    .dword 0x0               

    .text
    .global main

fibonacci_sum:
    addi sp, sp, -32      
    sd ra, 24(sp)         
    sd s0, 16(sp)         
    sd a4, 8(sp)          

    la t0, lsp            
    ld t1, 0(t0)          
    mv t2, sp             
    blt t2, t1, update_lsp
    j check_hsp

update_lsp:
    sd t2, 0(t0)          

check_hsp:
    la t0, hsp            
    ld t1, 0(t0)          
    bgt t2, t1, update_hsp
    j continue_fun

update_hsp:
    sd t2, 0(t0)          

continue_fun:
    beqz a4, zero_case
    li t6, 1
    beq a4, t6, one_case

    addi a4, a4, -1       
    jal ra, fibonacci_sum     
    mv a2, a0            

    ld a4, 8(sp)         
    jal ra, fibonacci     
    add a0, a2, a0       

return_fibonacci_sum:
    ld ra, 24(sp)        
    ld s0, 16(sp)        
    addi sp, sp, 32      
    ret                  

zero_case:
    li a0, 0
    j return_fibonacci_sum

one_case:
    li a0, 1
    j return_fibonacci_sum

fibonacci:
    addi sp, sp, -16      
    sd ra, 8(sp)         
    sd s0, 0(sp)         

    beqz a4, fib_zero
    li t6, 1
    beq a4, t6, fib_one

    addi a4, a4, -1       
    jal ra, fibonacci     
    mv a2, a0            

    ld a4, 8(sp)         
    addi a4, a4, -2      
    jal ra, fibonacci     
    add a0, a2, a0       

fib_return:
    ld ra, 8(sp)        
    ld s0, 0(sp)        
    addi sp, sp, 16      
    ret                  

fib_zero:
    li a0, 0
    j fib_return

fib_one:
    li a0, 1
    j fib_return

main:
    la t1, n
    ld a4, 0(t1)          
    jal fibonacci_sum  

    la t4, lsp
    ld t4, 0(t4)
    la t5, hsp
    ld t5, 0(t5)
    sub a1, t5, t4      
