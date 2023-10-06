.data

	varA: .word 0
	
.text
	la $t0, varA
	lw $s0, 0($t0)
	j while_verifica
while_codigo:
	addi $s0, $s0, 1
	sw $s0, 0($t0)


while_verifica:
	
	bne $s0, 9, while_codigo
while_fim: