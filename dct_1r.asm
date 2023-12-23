# Do not use label "main" in your functions, it should be used only in the calling function
.globl dct_r

dct_r:
	addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp)	 # save the return address (ra register) 
			# save other registers to stack if needed
	
	
	mv t0,x10	#arr_y
	mv s11, x11 	#arr_dct_y memory of final array
	li t2, 0	#store value 0
	li t3, 4 	#value for 4 indexing
	li t4, 7	# store value 56
	li t5, 0	#counter
	li a2, 2	#for 2nd loop
	li a3, 3	#for 3nd loop
	li a4, 4	#for 4th loop
	li t1, 0	#load i for loop
	li t6, 8 	#1counter for 8  	
	
	
	
loop:	
	beqz   t6, exit
	
	add a1, t2, t1	#add 0 to i
	mul a1, a1, t3	#offset locaion
	add a1, a1, t0	#address to pull value from arr_y
	lw  s2, 0(a1)	#load x[i+0]
	
	add a1, t4, t1	#add 56 +i
	mul a1, a1, t3	#offset locaion
	add a1, a1, t0	#address to pull value from arr_y
	lw  s3, 0(a1)	#load x[i+56]
	addi t5,t5,1	#counter increment

first:  
	beq a4,t5 fourth
	beq a3,t5 third
	beq a2,t5, second	
	add s4,s2,s3		#a00
	sub s5, s2, s3		#a70
	addi t2,t2,1		#x[j+1]
	addi t4,t4, -1		#x[j+6]
	j loop

second:	
	add s6,s2,s3		#a10
	sub s7,s2,s3		#a60
	addi t2,t2,1		#x[i+16]
	addi t4,t4, -1		#x[i+40]
	j loop
third:	
	add s8,s2,s3		#a20	
	sub s9,s2,s3		#a50
	addi t2,t2,1		#x[i+24]
	addi t4,t4, -1 		#x[i+32]
	j loop
fourth:	
	add s10, s2,s3		#a30
	sub s2,s2,s3		#a40
	addi t5,t5,1 		#final counter
	j next
	
next:	
	li t2,0		#restore value
	li t4, 56	#restore value
	li t5, 0
	add a2,s4,s10		#a01
	sub s4,s4,s10		#a31
	add a3,s6,s8		#a11
	sub s6,s6,s8		#a21
	add a4,s2,s9		#neg_a41
	add s2,s9,s7		#a51
	add s9,s7,s5		#a61
	j next_next

next_next:

	add s6,s6,s4	#a22
	li a0,11585
	mul s6,s6,a0	#a23
	
	sub a5,s9,a4	# a61-a41
	li a0,6270 
	mul a5,a5,a0 	#mul5
	
	li a0, 8867
	mul a4,a4,a0	#neg_a41*8867
	sub a4,a4,a5	#a43
	
	li a0, 11585
	mul s2,s2,a0	#a53
	
	li a0,21407
	mul s9,s9,a0	#a61*21407
	sub s9,s9,a5	#a63

temp:
	
	slli s5,s5, 14	#temp1
	add a1, s5, s2  #a54
	sub s2, s5, s2	#a74
	
saving:
	add a5,a2,a3 	#a01+a11
	#slli a5,a5,2	#shift left 2
	sub a2,a2,a3
	#slli a2,a2,2	#shift left 2
	
	li t2,0
	li s10, 8192
	li s7, 6
	
	add a0, t2, t1	#add 0 to i
	mul a0, a0, t3	#offset locaion
	add a0, a0, s11	#address to save to dct_arr_y
	#srai a5,a5,2
	sw a5, 0(a0)	#y[i+0]
	
	addi t2,t2, 4
	add a0, t2, t1	#add 0 to i
	mul a0, a0, t3	#offset locaion
	add a0, a0, s11	#address to save to dct_arr_y
	#srai a2,a2,2
	sw a2, 0(a0)	#y[j+4]
	
	slli s5,s4,14 	#update temp1
	add  s4,s5,s6	#temp= temp1+ a23
	
	add s4,s4,s10
	srai s4,s4,14	#(temp+0x800)>>12
	addi t2,t2,-2	#2
	
	add a0, t2, t1	#add 0 to i
	mul a0, a0, t3	#offset locaion
	add a0, a0, s11	#address to save to dct_arr_y
	sw  s4, 0(a0)	#y[i+16]
	
	sub s4,s5,s6
	add s4,s4,s10
	srai  s4,s4,14	#(temp+0x800)>>12
	addi t2,t2,4	#6
	
	add a0, t2, t1	#add 0 to i
	mul a0, a0, t3	#offset locaion
	add a0, a0, s11	#address to save to dct_arr_y
	sw  s4, 0(a0)	#y[i+48]
	
	add s4,s2,a4	#a74+a43
	add s4,s4,s10
	srai s4,s4,14
	addi t2,t2,-1	#40 index
	
	add a0, t2, t1	#add 0 to i
	mul a0, a0, t3	#offset locaion
	add a0, a0, s11	#address to save to dct_arr_y
	sw  s4, 0(a0)	#y[i+40]
	
	add s4,a1,s9	#a54+a63
	add s4,s4,s10
	srai s4,s4,14
	addi t2,t2,-4	#8 index
	
	add a0, t2, t1	#add 0 to i
	mul a0, a0, t3	#offset locaion
	add a0, a0, s11	#address to save to dct_arr_y
	sw  s4, 0(a0)	#y[i+8]
	
	sub s4,a1,s9	 #a54-a63
	add s4,s4,s10
	srai s4,s4,14
	addi t2,t2, 6 	# 7
	
	add a0, t2, t1	#add 0 to i
	mul a0, a0, t3	#offset locaion
	add a0, a0, s11	#address to save to dct_arr_y
	sw  s4, 0(a0)	#y[i+56]
	
	sub s4,s2,a4	#a74-a43
	add s4,s4,s10
	srai s4,s4,14
	addi t2,t2,-4	#[56-32=24]
	
	add a0, t2, t1	#add 0 to i
	mul a0, a0, t3	#offset locaion
	add a0, a0, s11	#address to save to dct_arr_y
	sw  s4, 0(a0)	#y[i+24]
	
	
outer:	
	addi t1,t1,8
	addi t6,t6,-1
	li t2, 0	#store value 0
	li t4, 7	# store value 56
	li a2, 2
	li a3, 3
	li a4, 4
	li t5,0
	j loop
	
	
exit:
	li a0,0
	# restore registers from stack if needed
	lw ra, 0(sp) # Restore return address register
	addi sp, sp, 4 # deallocate space for stack frame
	ret # return to calling point
