          .globl MAX
          .globl SIZE
          .globl getCount
          .globl setCount
          .globl println

#-----------------------------

          .data 
MAX:      .word  2147483647;
SIZE:     .byte  32;
count:    .word  0
temp1:	  .half	-1;	
  
#-----------------------------

          .text

#-----------------------------

getCount: lw     $v0, count($0)
          jr     $ra

#-----------------------------

          
setCount: sw     $a0, count($0)   
          jr     $ra

#-----------------------------

          
println: addi	$v0,	$zero,	11
	 addi	$a0,	$0,	0xA
	 syscall
	 jr	$ra
