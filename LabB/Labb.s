        #Name        : Rajkumar Balakrishnan Lakshmi
        #Std. Number : 213141197
        #Course      : EECS 2021
        #Lab         : 02
        #EECS ACCOUNT: kumarraj
        
        .globl fini
        .text
main:   #---------------------
         addi     $v0, $0, 5        # v0 = readInt 
         syscall         
         add      $t0, $0, $v0      # copy value of v0 into t0
        #--------------------- 
         addi     $v0, $0, 5        # v0 = readInt 
         syscall         
         add      $t1, $0, $v0      # copy value of v0 into t1
        #--------------------- 
         sub     $t2, $t1, $t0      # t2 = t1-t0
         sub     $t3, $t0, $t1      # t3 = t0-t1
        #---------------------  
         slt      $t4, $t0, $t1     # t4=1 if t0<t1
         beq      $t4, $0, XX       # jump to XX if t0>=t1
         addi     $v0, $0, 1        # service #1 
         add      $a0, $0, $t2      # printInt 
         syscall                    # do print 
         j fini
        #---------------------         
XX:      addi    $v0, $0, 1         # service #1
         add     $a0, $0, $t3       # printInt
         syscall                    # do print
         #---------------------         
fini:   jr      $ra                 # return 