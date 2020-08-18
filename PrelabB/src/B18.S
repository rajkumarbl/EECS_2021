
  .text
main:
  addi   $a0, $0, 0        # initialize a0 to 0
  addi   $v0, $0, 5        # readInt
  syscall
  addi   $t0, $v0, 0       # copy input into t0

  addi   $t1, $0, 1024     # use 1024 as our mask (t1)
  xor    $a0, $t0, $t1     # xor t0 with our mask (t1) save int a0

  addi   $v0, $0, 1        # printInt
  syscall
fini:
  jr     $ra               # return

