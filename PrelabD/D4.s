        .globl	Fraction
	.globl	getNumerator
	.globl	getDenominator
        .globl	adding
	.globl	setNumerator
	.globl	setDenominator
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

adding:
	#-----------------------------------
	#Accept Argument: $a1, $a2 for two Fraction address
	#return $v0, new address of Fraction object

	#allocate room for variables
	addi	$v0,	$0,	9	#allocate address service
	addi	$a0,	$0,	8	#allocate 8 bytes for two words
	syscall				#--> Return address in $v0

	lw	$t1,	0($a1)
	lw	$t2,	0($a2)
	mult	$t1,	$t2
	mflo	$t0
	sw	$t0,	0($v0)

	lw	$t1,	4($a1)
	lw	$t2,	4($a2)
	mult	$t1,	$t2
	mflo	$t0
	sw	$t0,	4($v0)

	jr	$ra

setNumerator:
	#----------------------------
	#Accept Argument: $a0 - object, $a1 - value
	sw	$a1,	0($a0)
	jr	$ra

setDenominator:
	#----------------------------
	#Accept Argument: $a0 - object, $a1 - value
	sw	$a1,	4($a0)
	jr	$ra

