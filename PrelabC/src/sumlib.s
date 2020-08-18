        .globl MAX
        .globl SIZE
        .globl sumdiff
#-----------------------------
	.data
sum:	.word 0;
diff:	.word 0;

#----------------------------------------
	.text
#----------------------------------------
sumdiff: addi $t0, $a0, 0  
         addi $t1, $a1, 0  
         addi $t2, $a2, 0  
         
         add  $t3, $t0, $t1  
         sub  $t4, $t1, $t2
         
         addi $v0, $t3, 0
         addi $v1, $t4, 0

          
