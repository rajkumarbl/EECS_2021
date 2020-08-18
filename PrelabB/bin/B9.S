 .globl done
  .text

main:
      addi   $s0, $0, 0     # initialize s0 to 0
      addi   $v0, $0, 5     # readInt
      syscall
      add    $t0, $0, $v0   # copy input into t0
      add    $t5, $0, $0    # initialize t5 to 0
loop:
      slt $t6, $t5, $t0
      beq $t6, $0, done
      add $s0, $s0, $t5
      addi $t5, $t5, 1
      j loop 
done:
      addi $v0, $0, 1
      add $a0, $0, $s0
      syscall
      jr $ra                # return 