#load and store 
	#	words (lw and sw), 
	#	half words (lh and sh), 
	#	and bytes (lb and sb).
	
	.text
main:   sw $ra, 0($sp)
        addi $sp, $sp, -4

        lw $a0, MAX($0)
        addi $v0, $0, 1
        syscall

        addi    $a0, $0, 0xA
        addi    $v0, $0, 11
        syscall

        lbu $a0, SIZE ($0)
        addi$v0, $0, 1
        syscall

        addi    $a0, $0, 0xA
        addi    $v0, $0, 11
        syscall

        jal     getCount
        add     $a0, $0, $v0
        addi    $v0, $0, 1
        syscall
        
        addi    $sp, $sp, 4
        lw      $ra, 0($sp)
        jr      $ra
