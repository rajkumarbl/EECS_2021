.text
main:
	#-----------------------------------
	sw	$ra,	0($sp)
	addi	$sp,	$sp,	-4	#push one to stack
	#-----------------------------------
	#Fraction a = new Fraction(3,8); 
	addi	$a0,	$0,	3
	addi	$a1,	$0,	8
	jal	Fraction			#v0 = new Fraction($a0, $a1)
	add	$s0,	$0,	$v0	#save v0 ---> s0


	#Fraction b = new Fraction(1,2); 
	addi	$a0,	$0,	1
	addi	$a1,	$0,	2
	jal	Fraction			#v0 = new Fraction($a0, $a1)
	add	$s1,	$0,	$v0	#save v0 ---> s0


	#println(s0);
	add	$a0,	$0,	$s0
	jal	printFraction
	jal	println

	#println(s1);
	add	$a0,	$0,	$s1
	jal	printFraction
	jal	println

	#s0.adding(s1)
	add	$a0,	$0,	$s0
	add	$a1,	$0,	$s1
	jal	adding

	#println(s2);
	add	$a0,	$0,	$s0
	jal	printFraction
	jal	println


	#s0.subtract(s1)
	add	$a0,	$0,	$s0
	add	$a1,	$0,	$s1
	jal	subtract

	#println(s2);
	add	$a0,	$0,	$s0
	jal	printFraction
	jal	println

	
	#s0.divide(s1)
	add	$a0,	$0,	$s0
	add	$a1,	$0,	$s1
	jal	divide

	#println(s2);
	add	$a0,	$0,	$s0
	jal	printFraction
	jal	println


	#-----------------------------------
	addi	$sp,	$sp,	4	#pop one from stack
	lw	$ra,	0($sp)
	#-----------------------------------
	jr	$ra
