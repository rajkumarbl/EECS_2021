.text

main:
	#-----------------------------------
	sw	$ra,	0($sp)
	addi	$sp,	$sp,	-4	#push one to stack
	#-----------------------------------
	#Fraction a = new Fraction(3,8); 
	addi	$v0, $0, 5	
	syscall
	add	$a0, $v0, $0	        #a0 = input from the user

	addi	$v0, $0, 5	
	syscall
	add 	$a1, $v0, $0	        #a1 = input from the user

	jal	Fraction		#v0 = new Fraction($a0, $a1)
	add	$s0,	$0,	$v0	#save v0 ---> s0


	#Fraction b = new Fraction(1,2); 
	addi	$a0,	$0,	1
	addi	$a1,	$0,	2
	jal	Fraction		#v0 = new Fraction($a0, $a1)
	add	$s1,	$0,	$v0	#save v0 ---> s1

	add	$a0,	$0,	$s0
	jal	printFraction
	jal	println


	add	$a0,	$0,	$s1
	jal	printFraction
	jal	println

	#-----------------------------------
	addi	$sp,	$sp,	4	#pop one from stack
	lw	$ra,	0($sp)
	#-----------------------------------
	jr	$ra
