#load and store 
	#	words (lw and sw), 
	#	half words (lh and sh), 
	#	and bytes (lb and sb).
	
	.text
main:   lw $a0, MAX($0)
        addi $v0, $0, 1
        syscall

        addi    $a0, $0, 0xA
        addi    $v0, $0, 11
        syscall

        addi $t0, $0, 4
        lb   $a0, MAX($t0)
        addi$v0, $0, 1
        syscall

        addi    $a0, $0, 0xA
        addi    $v0, $0, 11
        syscall

        addi $t0, $0, 8
        lb   $a0, MAX($t0)
        addi$v0, $0, 1
        syscall

        addi    $a0, $0, 0xA
        addi    $v0, $0, 11
        syscall

        addi $t0, $0, -4
        lw  $a0, SIZE($t0)
        addi$v0, $0, 1
        syscall
        
        jr $ra

