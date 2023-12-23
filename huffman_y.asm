# Do not use label "main" in your functions, it should be used only in the calling function

.globl huffman_y



huffman_y:

	addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)

	sw ra, 0(sp) # save the return address (ra register) 

	# save other registers to stack if needed



	li t0, 0 	#out index

	li t1, 0 	#size of bits

	li t2, 4	#indexing 32 bit

	li t3, 1 	#in_index

	#li t4, 1	#code

	li t5, 240	#0xf0

	li t6, 10	

	li t4, 15

	li a7,65280

	li s3,61

	li s4,1

	#li s11, 0 	#size of bits



	

	lw s0, 0(x10)	#load x_val[0]

	mv s1,s0



	#beqz s3,outer_end



get_size:

	beqz s0,main

	bltz s0, two_comp

	j while_get_size



two_comp:

	not s1,s0	#~val

	addi s1,s1,1	#~val+1



while_get_size:	

	beqz s1,main

	addi t1,t1,1

	srai s1,s1,1

	j while_get_size



main:	

#	bgtz t0,break

	mul s11,t2,t1		#index with size

	add s10,x12,s11		#huffman_table_DC_Y

	lw s9, 0(s10)		

	

	mul s10,t0,t2		#index with out index

	add s8, x15,s10

	sw s9, 0(s8)		 #y_val[out index]

	

	add s7,s11,x13		#dc_huffman_size

	lw s9, 0(s7)	

	

	add s6, s10,x16

	sw s9, 0(s6)		#y_size

	

	addi t0,t0,1		#increment index

	

	mul s10,t0,t2

	add s10,s10,x15

	sw s0, 0(s10)		#y_val



	mul s10, t0,t2

	add s10, s10,x16

	sw t1,0(s10)		#y_size

	

	addi t0,t0,1		#increment index

outer:

	beqz s3,outer_end



code_while:

	

	mul s11,t3,t2

	add s10,s11,x11

	lw s9,0(s10)		#x_code in s9 CODE

	

	add s8,s11,x10

	lw s5,0(s8)		#x_val in s5

	

	addi t3,t3,1		#increment in_index++



breakpoint:	

	bne s9,t5, if	 #code==0xf0

	j get_AC_y_val	

	

get_AC_y_val:

	#beq  s5,s4,exit

	#beqz s9,exit

	mv s8,s9

	blt s8,t6, first	#code<0x10

	bge s8,t5,second	#code>=f0=240

	j middle		#else 10>=code<f0





first:  

	and s8,s8,t4

	mul s8,s8,t2

	add s8,s8,x14

	lw s7,0(s8)

	j get_size_AC



second:

	and s8,s8,t4

	mul s8,s8,t2

	add s8,s8,x14

	lw s7, 0(s8)		#s7 value from get_size_Ac

	j get_size_AC



middle:

	and s8,s8,t4

	addi s8,s8,-1

	mul s8,s8,t2

	add s8,s8,x14

	lw s7, 0(s8)		#s7 value from get_size_Ac



get_size_AC:

	mv s8,s7	

	li s0,0			#size = 0

	

	and s1,s8,a7

	beqz s1, next

	srai s8,s8,8

	ori s0,s0,8

next:

	and s1,s8,t5

	beqz s1, next_next

	srai s8,s8,4

	ori s0,s0,4

next_next:

	li s2,12

	and s1,s8,s2

	beqz s1,end

	srai s8,s8,2

	ori s0,s0,2

end:	

	li s2,2

	and s1,s8,s2

	beqz s1,return

	ori s0,s0,1

return:		

	li s2,2			#return size

	addi s0,s0,1		

	bge  s0,s2, save_ysize

	mv s0,s2			

	

save_ysize:

	#beqz s7,outer_end

	#beqz s0,outer_end

	mul s8,t0,t2

	add s6,s8,x15

	sw s7,0(s6)	#save y_val	

	

	add s6,s8,x16

	sw s0,0(s6)	#save y_size

	

	#addi t3,t3,1

	

	#mul s8,t3,t2

	#add s6,s8,x11

	#lw s9,0(s6)

	

	#add s6,s8,x10

	#lw s5,0(s6)

	

	addi t0,t0,1

	j exit

if:	

	j get_AC_y_val





exit:		

	mul s8,t0,t2

	add s6,s8,x15

	sw s5,0(s6)

	

	

get_size2:

	li t1,0

	beqz s5,final

	bltz s5, two_comp2

	j while_get_size2



two_comp2:

	not s5,s5	#~val

	addi s5,s5,1	#~val+1



while_get_size2:	

	beqz s5,final

	addi t1,t1,1

	srai s5,s5,1

	j while_get_size2

final:	

	

	mul s8,t0,t2

	add s6,s8,x16

	sw t1,0(s6)



another:

	addi t0,t0,1

breakpointtt:

	addi s3,s3,-1

	#beqz s9,outer_end

	j outer				#end of program

outer_end:		

	# restore registers from stack if needed

	lw ra, 0(sp) # Restore return address register

	addi sp, sp, 4 # deallocate space for stack frame

	ret # return to calling point

	

