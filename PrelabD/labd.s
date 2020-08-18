           .globl	append  
           .globl	list
	   .text
list:      #-----------------------------------
	   #Accept Argument: $a0 max size

	   #allocate room for variables
	   addi	$v0,	$0,	9	#allocate address service
	   #addi	$a0,	$0,	$a0	#allocate a0 bytes for words
	   syscall				#--> Return address in $v0

	   sb	$0,	0($v0)		# null terminator
  
	   jr	$ra
  
append:    #-----------------------------------
	   #Accept Argument: $a0 reference, $a1 char

findnext:  lb	$t1,	0($a0)	
	   beq	$t1,	$0,	addvalue
	   add	$a0,	$a0,	1
	   j	findnext

addvalue:  sb	$a1,	0($a0)
	   sb	$0,	1($a0)
	   jr	$ra


