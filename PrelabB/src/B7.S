   .globl fini
        .text
main:   #---------------------
        addi    $v0, $0, 5             # v0 = readInt
        syscall
        add     $t0, $0, $v0           # copy value of v0 into t0
        addi    $t1, $0, 7             # t1 = 7
        add     $t2, $t0, $t1          # t2 = t0+t1
        sub     $t3, $t0, $t1          # t2 = t0-t1
        #---------------------
        addi    $v0, $0, 1             # service #1
        slt     $t4, $t0, $t1          # $t4=1 if t0<t1
        bne     $t4, $zero, XX         # jump to XX if t0>=t1
        add     $a0, $0, $t3           # printInt (sub)
        syscall                        # do print
        j fini
XX:     add     $a0, $0, $t2           # printInt (sum)
        syscall                        # do print
        #---------------------
fini:   jr      $ra                    # return 