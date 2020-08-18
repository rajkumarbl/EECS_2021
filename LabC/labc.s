        #Name        : Rajkumar Balakrishnan Lakshmi
        #Std. Number : 213141197
        #Course      : EECS 2021
        #Lab         : 03
        #EECS ACCOUNT: kumarraj	


	.text		
main: #------------------------------
	sw	$ra, 0($sp)
	addi	$sp, $sp, -4

	addi	$v0, $0, 5	
	syscall
	add	$a0, $v0, $0	
	addi	$v0, $0, 5	
	syscall
	add 	$a1, $v0, $0	
	addi    $v0, $0, 5	
	syscall
	add 	$a2, $v0, $0	
	
	jal 	sumdiff

	addi	$sp, $sp, 4
	lw 	$ra, 0($sp)
	jr 	$ra
