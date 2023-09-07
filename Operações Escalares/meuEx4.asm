.data

	varA: .word 0
	varB: .word 0
	
	
.text 

	#vaB = 1000000
	lui $t0, 0x0000000f
	addiu $t1, $t0, 0x00004340
	la $s0, varB
	sw $t1, 0($s0)
	li $t1, 10
	
	# varA = 10
	la $s0, varA
	sw $t1, 0($s0)
	
	