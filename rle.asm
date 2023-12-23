
# Do not use label "main" in your functions, it should be used only in the calling function
.globl rle

rle:
	addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
	# save other registers to stack if needed


	li t0, 0	#zero count
	li t1, 1	#out_index
	li t2, 1	# i
	li t3, 64 	#counter
	
	li s11, 4	#indexing
	li s10, 15	# zero count 15
	li s9, 240	#0x00f0
	li s8,0 	#0x0000
	li s7, 0	#size=0
	li s6, 65280
	li s4,1
	
	sw t0, 0(x11) 	#y_code[0]
	lw t5, 0(x10)
	sw t5, 0(x12)	#y_val[0]=x[0]

loop:	
	beq   t2,t3, exit
	
	mul t6, t2,s11 	#calculate offset address
	add t6, x10,t6 
	lw s0, 0(t6)	#val=x[i] in s0
	
	bnez s0, else
	addi t0,t0,1	#zero_count++
	addi t2,t2,1
	j loop

else:	
	ble  t0, s10, get_size
	
	mul t4, t1,s11
	add t6, x11,t4
	sw s9, 0(t6)		#y_code[index]
	
	add t6, x12,t4
	sw s8, 0(t6)		#y_val[index] for while
	addi t0,t0,-16		#zero count-16
	addi t1,t1,1 		#out_index++
	j else



get_size:
	  slli t4,t0,4		#zero_count<<4	
	  mv s5,s0
	  #li s7,0
	  bltz s0,val
	  j second

val:	
	not s5,s0	
	addi s5,s5,1		#val= ~val+1

second:	
	li s7,0
	and t6,s5,s6 		#val & 0xff00
	beqz t6, third
	srai  s5,s5,8
	ori s7,s7,8
third:	
	andi  t6,s5,240		#val & 0xf0
	beqz t6,fourth
	srai s5,s5,4
	ori s7,s7,4
fourth:	
	andi t6,s5,12
	beqz t6,last		#val & 0xc
	srai s5,s5,2
	ori s7,s7,2

last:
	andi t6,s5,2
	beqz t6, exit_size
	ori s7,s7,1		#return size +1 if (val & 0x2) true

exit_size:
	addi s7,s7,1		#return = size+1 in s7
	
	or t5,s7,t4
	
	mul t4, t1,s11
	add t6, x11,t4
	sw t5, 0(t6)		#y_code[index]
	
	mul t4, t1,s11
	add t6, x12,t4
	sw s0, 0(t6)		#y_val[outindex]
	
	addi t1,t1,1		#increment out index
	addi t2,t2,1		#increment i
	li t0, 0
	j loop

	
exit:	
	lw s3,252(x10)		#if x[63] != 0
	bnez s3,final
	j exit_exit
final:
	mul t4, t1,s11		#y_code[out_index] = 0x0000;
	add t6, x11,t4
	sw s8, 0(t6)
	
	add t6,x12,t4
	sw s4,0(t6)		#y_val[out_index] = 0x0001;
	
exit_exit:	
	# restore registers from stack if needed
	lw ra, 0(sp) # Restore return address register
	addi sp, sp, 4 # deallocate space for stack frame
	ret # return to calling point
	
