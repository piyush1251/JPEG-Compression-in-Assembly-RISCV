# Do not use label "main" in your functions, it should be used only in the calling function
.globl organize

organize:
	addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
	# save other registers to stack if needed

	# body of the function, write your code here
	li t0,8		#bit size 8
	li t1,0
	li s2,0
	li t5,32	#32 bit size of value
	li s3,67	#counter
	li s4,255	#byte check with ff
	li s6,1		#store 1
	li s5,255

reset:
	add t2,t1,x10
	lw s11,0(t2)	#val

	add t3,t1,x11
	lw s10,0(t3)	#size



superloop:	
	beqz s3, exit
	addi t1,t1,4
	
	add t2,t1,x10
	lw s9,0(t2)	#val 2
		
	add t3,t1,x11
	lw s8,0(t3)	#size 2
	#sw s9,40(x12)
	mv s7,s9
	
	bltz s9, complement 
	#bltz s8,exit
		
break:
	#beqz s3, exit
	sll s11,s11,s8		#shift left by size2
	add s10,s10,s8		#s10=size1+size2
	sub s10,s10,t0		#s10=s10-8
	or s11,s11,s9		#or s11,s9
	srl s1,s11,s10		#save 8 msb in s1 as first value of arr out
	sub s0,t5,s10		# s0=32-s10
	sll s11,s11,s0
	srl s11,s11,s0
	#addi t1,t1,-4
	add t4,s2,x12		#output index
	#sw s1,40(x12)
	beqz s1, superloop
	bltz    s1,complement
	bgt  s1,s5,complement
return:
	sw s1, 0(t4)		#SAVING OUTPUT array

	addi s2,s2,4
	
	addi s3,s3,-1
	#sw s1, 44(x12)
	#beqz s5,loop
	beq s5,s1 byte
	
	j superloop

byte:
	#addi s2,s2,4
	li s1,0
	#li s10,8
	add t4,s2,x12
	sw  s1,0(t4)
	addi s2,s2,4
	#addi t1,t1,4
	addi s5,s5,1
	#addi s3,s3,-1

	j superloop
	
complement:
	
	sub s7,t5,s8	#32-size2
	
	sll s9,s9,s7
	srl s9,s9,s7
	#addi s9,s9,-1	
	
	#addi s2,s2,-4
	#addi s3,s3,1
	#addi s2,s2,-4
	#addi s2,s2,-4
	j break
	
exit:	
	#sw s2,32(x12)
	# restore registers from stack if needed
	lw ra, 0(sp) # Restore return address register
	addi sp, sp, 4 # deallocate space for stack frame
	ret # return to calling point
	