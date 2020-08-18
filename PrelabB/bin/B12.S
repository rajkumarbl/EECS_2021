
  .text
main:
  addi   $a0, $0, 0        # initialize a0 to 0
  addi   $v0, $0, 5        # readInt
  syscall
  sll    $t0, $v0, 4       # shift the input left by 4 and save in t0
  sll    $t1, $v0, 1       # shift the input left by 1 and save in t1
  add    $a0, $t0, $t1     # add the results
  addi   $v0, $0, 1        # printInt
  syscall
fini:
  jr     $ra               # return
