
# Do not use label "main" in your functions, it should be used only in the calling function
.globl zigzag

zigzag:
	addi sp, sp , -4 # allocate space for stack frame by adujusting the stack pointer (sp register)
	sw ra, 0(sp) # save the return address (ra register) 
	# save other registers to stack if needed

	
	mv t0, x10
	mv t1, x11
	
	lw t2, 0(t0)	#y[0]=x[0]
	sw t2, 0(t1)
	
	lw t2, 4(t0)	#y[1]=x[1]
	sw t2, 4(t1)
	
	lw t2, 8(t0)	#y[5]=x[2]
	sw t2, 20(t1)
	
	lw t2, 12(t0) 	#y[6]=x[3]
	sw t2, 24(t1)
	
	lw t2, 16(t0)	#y[14] = x[ 4];
	sw t2, 56(t1)
	
	lw t2, 20(t0)	#y[15] = x[ 5];
	sw t2, 60(t1)
	
	lw t2, 24(t0)	#y[27] = x[ 6];
	sw t2, 108(t1)
	
	lw t2, 28(t0)	#y[28] = x[ 7];
	sw t2, 112(t1)
	
	lw t2, 32(t0)	#y[ 2] = x[ 8];
	sw t2, 8(t1)
	
	lw t2, 36(t0)	#y[ 4] = x[ 9];
	sw t2, 16(t1)
	
	lw t2, 40(t0)	#y[ 7] = x[10];
	sw t2, 28(t1)
	
	lw t2, 44(t0)	#y[13] = x[11];	
	sw t2, 52(t1)
 	
 	lw t2, 48(t0)		
	sw t2, 64(t1)  #y[16] = x[12];
				
   	lw t2, 52(t0)		
	sw t2, 104(t1)	#y[26] = x[13];

   	lw t2, 56(t0)		
	sw t2, 116(t1) # y[29] = x[14];

    	lw t2, 60(t0)		
	sw t2, 168(t1)	#y[42] = x[15];

   	 lw t2, 64(t0)		
	sw t2, 12(t1) #y[ 3] = x[16];

    	lw t2, 68(t0)		
	sw t2, 32(t1)	#y[ 8] = x[17];

  	 lw t2, 72(t0)		
	sw t2, 48(t1)	# y[12] = x[18];

    	lw t2, 76(t0)		
	sw t2, 68(t1)	#y[17] = x[19];

   	lw t2, 80(t0)		
	sw t2, 100(t1)	#y[25] = x[20];

    	lw t2, 84(t0)		
	sw t2, 120(t1)	#y[30] = x[21];

    	lw t2, 88(t0)		
	sw t2, 164(t1)	#y[41] = x[22];

   	lw t2, 92(t0)		
	sw t2, 172(t1)	# y[43] = x[23];

   	lw t2, 96(t0)		
	sw t2, 36(t1)	# y[ 9] = x[24];

  	lw t2, 100(t0)		
	sw t2, 44(t1)	# y[11] = x[25];

    	lw t2, 104(t0)		
	sw t2, 72(t1)	#y[18] = x[26];

   	lw t2, 108(t0)		
	sw t2, 96(t1)	# y[24] = x[27];

    	lw t2, 112(t0)		
	sw t2, 124(t1)	#y[31] = x[28];

   	lw t2, 116(t0)		
	sw t2, 160(t1)	# y[40] = x[29];

    	lw t2, 120(t0)		
	sw t2, 176(t1)	#y[44] = x[30];

   	lw t2, 124(t0)		
	sw t2, 212(t1)	# y[53] = x[31];

    	lw t2, 128(t0)		
	sw t2, 40(t1)	#y[10] = x[32];

    	lw t2, 132(t0)		
	sw t2, 76(t1)	#y[19] = x[33];

   	lw t2, 136(t0)		
	sw t2, 92(t1)	# y[23] = x[34];

    	lw t2, 140(t0)		
	sw t2, 128(t1)	#y[32] = x[35];

    	lw t2, 144(t0)		
	sw t2, 156(t1)	#y[39] = x[36];

   	lw t2, 148(t0)		
	sw t2, 180(t1)	# y[45] = x[37];

    	lw t2, 152(t0)		
	sw t2, 208(t1)	#y[52] = x[38];

    	lw t2, 156(t0)		
	sw t2, 216(t1)	#y[54] = x[39];

    	lw t2, 160(t0)		
	sw t2, 80(t1)	#y[20] = x[40];

    	lw t2, 164(t0)		
	sw t2, 88(t1)	#y[22] = x[41];

    	lw t2, 168(t0)		
	sw t2, 132(t1)	#y[33] = x[42];

    	lw t2, 172(t0)		
	sw t2, 152(t1)	#y[38] = x[43];

   	lw t2, 176(t0)		
	sw t2, 184(t1)	# y[46] = x[44];

    	lw t2, 180(t0)		
	sw t2, 204(t1)	#y[51] = x[45];

    	lw t2, 184(t0)		
	sw t2, 220(t1)	#y[55] = x[46];

    	lw t2, 188(t0)		
	sw t2, 240(t1)	#y[60] = x[47];

    	lw t2, 192(t0)		
	sw t2, 84(t1)	#y[21] = x[48];

    	lw t2, 196(t0)		
	sw t2, 136(t1)	#y[34] = x[49];

    	lw t2, 200(t0)		
	sw t2, 148(t1)	#y[37] = x[50];

    	lw t2, 204(t0)		
	sw t2, 188(t1)	#y[47] = x[51];

    	lw t2, 208(t0)		
	sw t2, 200(t1)	#y[50] = x[52];

    	lw t2, 212(t0)		
	sw t2, 224(t1)	#y[56] = x[53];

    	lw t2, 216(t0)		
	sw t2, 236(t1)	#y[59] = x[54];

    	lw t2, 220(t0)		
	sw t2, 244(t1)	#y[61] = x[55];

    	lw t2, 224(t0)		
	sw t2, 140(t1)	#y[35] = x[56];

    	lw t2, 228(t0)		
	sw t2, 144(t1)	#y[36] = x[57];

    	lw t2, 232(t0)		
	sw t2, 192(t1)	#y[48] = x[58];

    	lw t2, 236(t0)		
	sw t2, 196(t1)	#y[49] = x[59];

    	lw t2, 240(t0)		
	sw t2, 228(t1)	#y[57] = x[60];

   	lw t2, 244(t0)		
	sw t2, 232(t1)	# y[58] = x[61];

    	lw t2, 248(t0)		
	sw t2, 248(t1)	#y[62] = x[62];

    	lw t2, 252(t0)		
	sw t2, 252(t1)	#y[63] = x[63];
	
	
	
	
	
	
	
		
	

exit:	
	# restore registers from stack if needed
	lw ra, 0(sp) # Restore return address register
	addi sp, sp, 4 # deallocate space for stack frame
	ret # return to calling point
	
