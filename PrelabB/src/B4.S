    .globl fini
        .text
main:   #---------------------
        addi    $t0, $0, 60            # t0 = 60
        addi    $t1, $0, 7             # t1 = 7
        add     $t2, $t0, $t1          # t2 = t0+t1
        sub     $t3, $t0, $t1          # t3 = t0-t1
        #---------------------
        # print the sum
        addi    $v0, $0, 1             # service #1
        add     $a0, $0, $t2           # printInt
        syscall                        # do print
        #---------------------
        # print the space
        addi    $v0, $0, 11            # service #11
        addi    $a0, $0, ' '           # printChar
        syscall                        # do print
        #---------------------
        # print the sub
        addi    $v0, $0, 1             # service #1
        add     $a0, $0, $t3           # printInt
        syscall                        # do print
        #---------------------
fini:   jr      $ra                    # return 