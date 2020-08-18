        .text
main: 
	#-----------------------------------
	sw	$ra,	0($sp)
	addi	$sp,	$sp,	-4	#push one to stack
	#-----------------------------------

	addi	$a0,	$0,	9
	jal	list			#call the constructor
	add	$s0,	$0,	$v0


loop:	add	$a0,	$0,	$s0
	addi	$v0, $0, 5	
	syscall

	add 	$a1, $v0, $0	        #a1 = input from the user
	jal	append			# append 'input value'
        bne	$a1, $0,  loop

        add	$a0,	$0,	$s0
	addi	$v0, $0, 5	
	syscall

	add 	$a1, $v0, $0	        #a1 = input from the user
	jal	append			# append 'input value'

        add	$a0,	$0,	$s0
        jal	printvalue
        jal	println	
        
        #-----------------------------------
	addi	$sp,	$sp,	4	#pop one from stack
	lw	$ra,	0($sp)
	#-----------------------------------
	jr	$ra
     
