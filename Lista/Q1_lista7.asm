###############################
# int a[10] = {0,1,,2,3,4,5,6,7,8,9}
#int i,j,k
#int main(){
#	i=1
#goto abc;
#	a[4] = 123;
#	a[5] = 900;
#abc:
#	a[0] = i
#	j = a[0]
#	k = i + 3000
#	if(i == j)
#		a[2] = k - a[9]
#	else
#		a[2] = a[4]
#	if ((k < i) && (i < 600))
#		if(k == 6 || j >= i)
#			a[9] = 400
#		else
#			a[8] = 500
#
#	switch (a[j * 2 + 1]){
#	case 1:
#		
#
#
#}
####################################

.text
main:
# i = 1
	la $t0, var_i
	li $t1, 1
	sw $t1, 0($t0)
#pegando o endereço do vetor A
	la $s0, vet_a
#goto abc
	j abc

	li $s1, 123
	sw $s1, 16($s0)
	li $s1, 900
	sw $s1, 20($s0)



abc:
# a[0] = i
	lw $s1, 0($t0)
	sw $s1, 0($s0)
# j = a[0]
	la $t1, var_j
	lw $s1, 0($s0)
	sw $s1, 0($t1)
# k = i + 3000
	la $t2, var_k
	li $s1, 3000
	lw $s2, 0($t0)
	add $s3, $s1, $s2
	sw $s3, 0($t2)
#if (i == j)
	lw $s1, var_i
	lw $s2, var_j
	beq $s1, $s2, main_if_i_igual_j
main_else_i_igual_j:
# a[2] = a[4]
	lw $s1, 16($s0)
	sw $s1, 8($s0)
	j main_fim_if_i_igual_j
main_if_i_igual_j:
# a[2] = k - a[9]
	lw $s1, 36($s0)
	lw $s2, var_k
	not $s1, $s1
	addi $s1, $s1, 1
	add $s3, $s2, $s1
	sw $s3, 8($s0)
main_fim_if_i_igual_j:

# if ((k < i) && (i < 600))
	# (k < i)
	lw $s1, var_k
	lw $s2, var_i
	slt $a0, $s1, $s2
	# (i < 600)
	li $s1, 600
	slt $a1, $s2, $s1
	# (k < i) && (i < 600)
	and $t3, $a0, $a1
	# se for 0 (se for falso)
	beqz $t3, main_fim_if_k_menor_i_and_i_menor_600
		
main_if_k_menor_i_and_i_menor_600:
# if(k == 6 || j >= i)
	# k == 6
	lw $s1, var_k
	li $s2, 6
	seq $a0, $s1, $s2
	# i <= j
	lw $s1, var_j
	lw $s2, var_i
	sle $a1, $s2, $s1
	# k == 6 || i <= j
	or $t3, $a0, $a1
	# se não for 0 (se for verdadeiro)
	bnez $t3, main_if_k_igual_6_or_j_maior_igual_i
	
main_else_k_igual_6_or_j_maior_igual_i:
# a[8] = 500
	li $s1, 500
	sw $s1, 32($s0)
	j main_fim_if_k_igual_6_or_j_maior_igual_i
main_if_k_igual_6_or_j_maior_igual_i:
# a[9] = 400
	li $s1, 400
	sw $s1, 36($s0)
main_fim_if_k_igual_6_or_j_maior_igual_i:
main_fim_if_k_menor_i_and_i_menor_600:
















.data

vet_a: .word 0,1,2,3,4,5,6,7,8,9

var_i: .word 0
var_j: .word 0
var_k: .word 0
