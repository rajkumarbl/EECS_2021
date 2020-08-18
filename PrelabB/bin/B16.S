  .text
main:
  addi   $v0, $0, 5           # readInt
  syscall
  addi   $t0, $v0, 0          # copy input into t0
  
  # construct the mask (t6)
  addi   $t6, $0, 1024
  nor    $t6, $t6, $0

  and    $a0, $t0, $t6        # AND t0 with our mask (t6) and save in a0
  
  addi   $v0, $0, 1           # printInt
  syscall
fini:
  jr     $ra                  # return

