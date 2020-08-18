  .text
main:
  addi   $t0, $0, -60
  sra    $a0, $t0, 2
  add    $v0, $0, 1       # service #1 for printInt
  syscall
  add    $v0, $s0, 11     # service #11 for printChar
  add    $a0, $0, ' '
  syscall                 # print a space
  sll    $a0, $t0, 1
  add    $v0, $0, 1       # service #1 for printInt
  syscall                 # print a space
fini:
  jr     $ra              # return

