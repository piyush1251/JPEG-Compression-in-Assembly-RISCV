
# Do not use label "main" in your functions, it should be used only in the calling function
.globl q_y

q_y:
	addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
	# save other registers to stack if needed

	mv t0, x10
	mv t1, x11
	mv t2, x12
	li t4, 64
	li t3, 32768	# 0x8000 

loop:	
	
	beqz t4,exit
	
	lw s10,0(t1)	#load arr_dct_r
	lw t5,0(t0)	#load value from quantization table
	lw t6,0(t1)
	mul t6,t6,t5
	add t6,t6,t3
	srai  t6,t6,16	#rounding by shift right 16
	sw t6,0(t2)
	addi t0,t0,4	#increment pointer to next  location
	addi t1,t1,4
	addi t2,t2,4
	addi t4,t4,-1
	j loop
	
	

exit:	
	# restore registers from stack if needed
	lw ra, 0(sp) # Restore return address register
	addi sp, sp, 4 # deallocate space for stack frame
	ret # return to calling point
	
