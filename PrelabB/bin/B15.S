
  .text
main:
  addi   $v0, $0, 5            # readInt
  syscall
  addi   $t0, $v0, 0           # copy input into t0
  
  # construct the mask (t5)
  ori    $t5, $0, 0xffff
  sll    $t5, $t5, 16
  ori    $t5, $t5, 0xfbff

  and    $a0, $t0, $t5         # AND t0 with our mask (t5) and save in a0
  
  addi   $v0, $0, 1            # printInt
  syscall
fini:
  jr     $ra                   # return

