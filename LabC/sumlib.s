               #Name        : Rajkumar Balakrishnan Lakshmi
               #Std. Number : 213141197
               #Course      : EECS 2021
               #Lab         : 02
               #EECS ACCOUNT: kumarraj




		.globl sumdiff
		.globl printintln
		.text		
sumdiff:	#--------------------------------
		sw	$ra, 0($sp)
		addi	$sp, $sp, -4

		add 	$t0, $a0, $a1		
		sub	$t1, $a1, $a2		
		 
		
		add 	$a0, $0, $t0		
		jal 	printintln

				
		add 	$a0, $0, $t1		
		jal 	printintln

		addi	$sp, $sp, 4
		lw 	$ra, 0($sp)		
		jr	$ra

printintln:	#------------------------------
		addi 	$v0, $0, 1
		syscall
		addi    $v0, $0, 11	
		addi	$a0, $0, 10
		syscall	
		jr	$ra	
		
