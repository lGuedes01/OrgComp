.data

	varA: .word 0
	
.text
	la $t0, varA
	lw $s0, 0($t0)
while_codigo:
	addi $s0, $s0, 1
	sw $s0, 0($t0)

	bne $s0, 9, while_codigo
	# beq $s0, 9, while_fim -> mesma resultado do de cima
while_fim: