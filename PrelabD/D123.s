        .globl	Fraction
	.globl	getNumerator
	.globl	getDenominator
	.text
Fraction:
	#----------------------------
	#Accept Argument: $a0, $a1
	add	$t0,	$0,	$a0
	add	$t1,	$0,	$a1
	#receive arguments


	#allocate room for variables
	addi	$v0,	$0,	9	#allocate address service
	addi	$a0,	$0,	8	#allocate 8 bytes for two words
	syscall				#--> Return address in $v0

	sw	$t0,	0($v0)
	sw	$t1,	4($v0)

	
	jr	$ra

getNumerator:
	#----------------------------
	#Accept Argument: $a0
	lw	$v0,	0($a0)
	jr	$ra

getDenominator:
	#----------------------------
	#Accept Argument: $a0
	lw	$v0,	4($a0)
	jr	$ra
