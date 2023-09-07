.data 

var_A: .word 0
var_B: .word 2
var_C: .word 3

.text
	la $t0, var_B #pseudo comando que carrega o endereço de var_B no registrador $t0 # = lui $at, 0x00001001 ; ori $t0, $at, 0x00000004
	lw $t1, 0($t0) #carregando o valor reservado para var_B no registrador $t1
	
	la $t0, var_C #pseudo comando que carrega o endereço de var_C no registrador $t0 # = lui $at, 0x00001001 ; ori $t0, $at, 0x00000008
	lw $t2, 0($t0) #carregando o valor reservado para var_C no registrador $t2
	
	add $t3,$t2,$t1 #guardando a soma dos valores que estão em t1 e t2 em t3
	
	la $t0, var_A #pseudo comando que carrega o endereço de var_C no registrador $t0 # = lui $at, 0x00001001 ; ori $t0, $at, 0x00000000
	sw $t3, 0($t0) #armazena no endereço de var_A o valor que está em t3
