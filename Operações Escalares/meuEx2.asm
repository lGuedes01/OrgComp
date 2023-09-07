.data
	var_A: .word 0
	var_B: .word 1
	var_C: .word 2
	var_D: .word 3
	var_E: .word 4
	
.text

	la $t0, var_B
	lw $t1, 0($t0)
	
	la $t0, var_C
	lw $t2, 0($t0)
	
	la $t0, var_D
	lw $t3, 0($t0)
	
	la $t0, var_E
	lw $t4, 0($t0)
	
	add $t1, $t1, $t2
	add $t2, $t3, $t4
	add $s0, $t1, $t2
	
	la $t0, var_A
	sw $s0, 0($t0)
	