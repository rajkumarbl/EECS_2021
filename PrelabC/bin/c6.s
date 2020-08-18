          .globl MAX
          .globl SIZE
          .globl getCount
          .globl setCount
          .globl println
          .globl signum

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

#-----------------------------

signum:    slt    $t0, $a0, $0
           bne    $t0, $0, negative
           sgt    $t0, $a0, $0
           beq    $t0, $0, zero
           addi   $v0, $0, 1
           j      return
negative:  addi   $v0, $0, -1
           j      return
zero:      addi   $v0, $0, 0
           j      return
return:    lw     $t0, count($0)
           addi   $t0, $t0, 1
           sw     $t0, count($0)
           jr     $ra

   


