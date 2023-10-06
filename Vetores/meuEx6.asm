.data

	vet: .word 1,2,3,4,5
	vi: .word 0
	vj: .word 0
	vk: .word 0
	
	
.text
	la $t0, vi
	addi $s0, $zero, 1
	sw $s0,0($t0)
	
	la $t0, vj
	addi $s1, $zero, 2
	sw $s1,0($t0)
	
	la $t0, vk
	addi $s2, $zero, 0
	sw $s2,0($t0)
	
	la $t0, vet
	
	sll $t1,$s0,2
	add $t2, $t0, $t1 #endereço de vet[vi]
	
	sll $t1, $s1, 2
	add $t3, $t0, $t1 #endereço de vet[vj]
	
	sll $t1, $s2, 2
	add $t4, $t0, $t1 #endereço de vet[vk]
	
	lw $t2, 0($t2)
	lw $t3, 0($t3)
	
	add $t1, $t2, $t3
	
	sw $t1, 0($t0)
		
	
	
	
	
	