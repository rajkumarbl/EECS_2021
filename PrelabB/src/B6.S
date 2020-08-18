         .globl fini
         .text         
main:    #---------------------  
         addi     $t0, $0, 7        # t1 = 7 
         addi     $t1, $0, 5        # t2 = 5
         add      $t2, $t0, $t1     # t2 = t0+t1 
         sub      $t3, $t0, $t1     # t3 = t0-t1 
         #---------------------  
         beq $t0, $t1, XX 
         #---------------------  
XX:      addi     $v0, $0, 1        # service #1 
         add      $a0, $0, $t2      # printInt 
         syscall                    # do print 
         j fini
         #---------------------  
YY:      addi     $v0, $0, 1        # service #1 
         add      $a0, $0, $t3      # printInt 
         syscall                    # do print 
         j fini
         #---------------------         
fini:    jr  $ra               # return 
         