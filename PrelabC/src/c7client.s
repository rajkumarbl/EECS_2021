.text
	
main:		sw	$ra, 0($sp)
		addi	$sp, $sp, -4

 		lw	 $a0, MAX($0)
		addi	 $v0, $0, 1	
		syscall

		lbu	 $a0, SIZE($0)
		addi	 $v0, $0, 1
		syscall
		
	#-------System.out.println(a0)----------#
						
		addi    $v0, $0, 1		
	     	syscall				
		addi    $a0, $0, 10		
		addi    $v0, $0, 11		
		syscall				
						
	#--------------------------------------	#
				
		addi	$v0, $0, 5
		syscall
		add 	$a0, $0, $v0

		jal isPrime
		
		add	$a0, $0, $v0
		addi	$v0, $0, 1
		syscall

		addi	$sp, $sp, 4
		lw	$ra, 0($sp)

		jr $ra
