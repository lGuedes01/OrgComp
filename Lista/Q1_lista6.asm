.text

main:
# i = 1
la $t0, var_i
li $t1, 1
sw $t1 0($t0)
# j = 3
la $t0, var_j
li $t1, 3
sw $t1 0($t0)
# k = 4
la $t0, var_k
li $t1, 4
sw $t1 0($t0)
# a[0] = 5
la $s0, vet_a
li $s1, 5
sw $s1, 0($s0)
#a[2] = a[0] + 	20
lw $s2, 0($s0)
add $s1, $s2, 20
sw $s1, 8($s0)
#a[3] = a[4] + 200000;
lw $s2, 16($s0)
add $s1, $s2, 200000
sw $s1, 12($s0)
#a [ 4 ] = 10000;
li $s1, 10000
sw $s1, 16($s0)
#a [ 6 ] = a [ 7 ] - i ;
lw $s1, 28($s0)
lw $s2, var_i
not $s2, $s2
add $s2, $s2, 1
add $s1, $s1, $s2
sw $s1, 24($s0)
#a [ 7 ] = a [ 8 ] - a [ j ] ;
lw $s2, var_j
sll $s2, $s2, 2
add $s1, $s0, $s2
lw $s1, 0($s1)
not $s1, $s1
add $s1, $s1, 1
lw $s2, 32($s0)
add $s1, $s1, $s2
sw $s1, 28($s0)
#a [ k ] = a [ a [ i ] ] ;













.data
vet_a: .word 0,1,2,3,4,5,6,7,8,9 #int a[10] = {0,1,2,3,4,5,6,7,8,9}
var_i: .word 0 #int i
var_j: .word 0 #int j
var_k: .word 0 #int k