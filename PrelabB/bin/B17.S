  .text
main:
  addi   $v0, $0, 5          # readInt
  syscall
  addi   $t0, $v0, 0         # copy input into t0
  
  # construct the mask (t7)
  lui   $t7, 0xffff
  ori   $t7, $t7, 0xfbff

  and   $a0, $t0, $t7        # AND t0 with our mask (t7) and save in a0
  
  addi   $v0, $0, 1          # printInt
  syscall
fini:
  jr     $ra                 # return

