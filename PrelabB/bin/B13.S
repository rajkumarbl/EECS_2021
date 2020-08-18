
  .text
main:
  addi   $a0, $0, 0        # initialize a0 to 0
  addi   $v0, $0, 5        # readInt
  syscall
  add    $t0, $0, $v0      # copy v0 into t0
  sll    $a0, $t0, 21      # shift t0 left by 21 and save in a0
  srl    $a0, $a0, 31      # shift a0 right by 31 and save in a0 (value of bit #10)
  addi   $v0, $0, 1        # printInt
  syscall
fini:
  jr     $ra               # return
