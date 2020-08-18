         .text         
main:    #---------------------    
         addi     $t0, $0, 60 
         addi     $t1, $0, 7 
         div      $t0, $t1   
         mflo     $a0 
         add    $v0, $0, 1     # service #1 for printInt
         syscall
         #---------------------
         addi    $v0, $0, 11            # service #11
         addi    $a0, $0, ' '           # printChar
         syscall                        # do print
         #---------------------
         mfhi     $a0 
         add    $v0, $0, 1     # service #1 for printInt
         syscall
         #---------------------
         jr     $ra            # return
        