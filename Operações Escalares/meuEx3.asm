.data

	varA: .word 0
	varB: .word 1234
	
.text
	#varB = 1234
	la $t0, varB
	lw $t1, 0($t0)
	
	#varA = varB
	la $t0, varA
	sw $t1, 0($t0)