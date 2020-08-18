  .text
main:
  addi   $a0, $0, 0        # initialize a0 to 0
  addi   $v0, $0, 5        # readInt
  syscall
  add    $t0, $0, $v0      # copy v0 into t0
  andi   $a0, $t0, 0x400   # AND t0 with 2014 and save in a0
  beq    $a0, $0, PRINT    # if a0 is 0, jump to PRINT (skip changing a0)
  addi   $a0, $0, 1        # change a0 to 1
PRINT:
  addi   $v0, $0, 1        # printInt
  syscall
fini:
  jr     $ra               # return

