.globl	Fraction
	.globl	getNumerator
	.globl	getDenominator
	.globl	setNumerator
	.globl	setDenominator
	.globl	adding
	.globl	multiply
	.globl	subtract
	.globl	divide
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

adding:
	#-----------------------------------
	#Accept Argument: $a0 - this, $a1 - other object
	#Up
	lw	$t1,	0($a0)
	lw	$t2,	4($a1)
	mult	$t1,	$t2
	mflo	$t0

	lw	$t1,	4($a0)
	lw	$t2,	0($a1)
	mult	$t1,	$t2
	mflo	$t3

	add	$t0,	$t0,	$t3
	sw	$t0,	0($a0)

	#Down
	lw	$t1,	4($a0)
	lw	$t2,	4($a1)
	mult	$t1,	$t2
	mflo	$t0
	sw	$t0,	4($a0)

	jr	$ra

multiply:
	#----------------------------
	#Accept Argument: $a0 - this, $a1 - other object
	lw	$t1,	0($a0)
	lw	$t2,	0($a1)
	mult	$t1,	$t2
	mflo	$t1
	sw	$t1,	0($a0)

	lw	$t1,	4($a0)
	lw	$t2,	4($a1)
	mult	$t1,	$t2
	mflo	$t1
	sw	$t1,	4($a0)

	jr	$ra

subtract:
	#----------------------------
	#Accept Argument: $a0 - this, $a1 - other object
	#-----------------------------------
	sw	$ra,	0($sp)
	addi	$sp,	$sp,	-4	#push one to stack
	#-----------------------------------
	lw	$t0,	0($a1)
	lw	$t1,	4($a1)
	sub	$t0,	$zero,	$t0

	#.prepare
	add	$t2,	$zero,	$a0
	#allocate room for variables
	addi	$v0,	$0,	9	#allocate address service
	addi	$a0,	$0,	8	#allocate 8 bytes for two words
	syscall				#--> Return address in $v0

	#save word
	sw	$t0,	0($v0)
	sw	$t1,	4($v0)

	#a1 = new object
	add	$a0,	$zero,	$t2
	add	$a1,	$zero,	$v0
	jal	adding
	#-----------------------------------
	addi	$sp,	$sp,	4	#pop one from stack
	lw	$ra,	0($sp)
	#-----------------------------------
	jr	$ra

divide:
	#----------------------------
	#Accept Argument: $a0 - this, $a1 - other object
	#-----------------------------------
	sw	$ra,	0($sp)
	addi	$sp,	$sp,	-4	#push one to stack
	#-----------------------------------
	#.prepare
	add	$t2,	$zero,	$a0
	#allocate room for variables
	addi	$v0,	$0,	9	#allocate address service
	addi	$a0,	$0,	8	#allocate 8 bytes for two words
	syscall				#--> Return address in $v0

	lw	$t0,	0($a1)
	lw	$t1,	4($a1)
	sw	$t0,	4($v0)
	sw	$t1,	0($v0)

	add	$a0,	$zero,	$t2
	add	$a1,	$zero,	$v0
	
	jal	multiply
	#-----------------------------------
	addi	$sp,	$sp,	4	#pop one from stack
	lw	$ra,	0($sp)
	#-----------------------------------
	jr	$ra

