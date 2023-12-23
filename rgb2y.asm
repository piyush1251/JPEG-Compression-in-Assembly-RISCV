# Do not use label "main" in your functions, it should be used only in the calling function
.globl rgb2y

rgb2y:
	addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) 	# save the return address (ra register) 
			# save other registers to stack if needed
	mv t0, x10   
	mv t1, x11
	mv t2, x12
	mv s11, x13
	li t3,38	#load 38
	li t4,75	#load 75
	li t5,15	#load 15
	li t6,16320	#load 16320
	li s10, 64	#counter for 64 values
	
	
loop:	
	beqz s10, exit		#check if counter to 0
	lw  s2, 0(t0)		#load  value of R
	lw s3, 0(t1)		#load value of G
	lw s4, 0(t2)		#load value of B
	mul s2,s2,t3		#multiply R*38
	mul s3,s3,t4		#multiply G*75
	mul s4,s4,t5		#multiply B*15
	add s2,s2,s3		#add R+G
	add s2,s2,s4		#R+G+B
	sub s2,s2,t6		#sub RGB-16320
	srai s2,s2,7		#Shift right arithmetic immediate
	
	addi t0,t0,4		#next location of r
	addi t1,t1,4	
	addi t2,t2,4
	sw s2, 0(s11)
	addi s11, s11, 4	#array y
	addi s10,s10,-1		#counter for 64 values
	j loop
	
	
	

	
	# body of the function, write your code here
	
exit:	
	# restore registers from stack if needed
	lw ra, 0(sp) # Restore return address register
	addi sp, sp, 4 # deallocate space for stack frame
	ret # return to calling point
