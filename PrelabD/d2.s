           .globl	append  
           .globl	list
	   .text

newc:    #-----------------------------------
	   #Accept Argument: $a0 reference, $a1 char
       
           addi	$v0,	$0,	9	#allocate address service
           addi $a0, $0, 8 
	   syscall			#--> Return address in $v0 
           sw   $t0,    0($v0)    
           sw   $t1,    4($v0)      

