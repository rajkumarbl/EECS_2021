.globl	SB
	.globl	append
	.globl	setCharAt
	.text
SB:
	#-----------------------------------
	#Accept Argument: $a0 max size

	#allocate room for variables
	addi	$v0,	$0,	9	#allocate address service
	#addi	$a0,	$0,	$a0	#allocate a0 bytes for two words
	syscall				#--> Return address in $v0

	sb	$0,	0($v0)		# null terminator

	jr	$ra


append:
	#-----------------------------------
	#Accept Argument: $a0 reference, $a1 char
findnext:	lb	$t1,	0($a0)	
	beq	$t1,	$0,	addchar
	add	$a0,	$a0,	1
	j	findnext
addchar:	sb	$a1,	0($a0)
	sb	$0,	1($a0)
	jr	$ra



setCharAt:
	#-----------------------------------
	#Accept Argument: $a0 reference, $a1 char, $a2 position
	add	$a0,	$a0,	$a2
	sb	$a1,	0($a0)	
	jr	$ra

    Contact GitHub API Training Shop Blog About 


