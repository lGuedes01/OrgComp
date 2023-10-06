# matriz[2][4] = matriz[1][3] + matriz[2][2]
#matriz[1][3] = col[l1]; l1[3]

la $t0, col

lw $t1, 4($t0)# l1
lw $s1, 12($t1)# l1[3]

lw $t1, 8($t0) # l2
lw $s2, 8($t1) # l2[2]

lw $t1, 8($t0) # l2
la $t2, 16($t1)# l2[4]
add $s3, $s1, $s2# matriz[1][3] + matriz[2][2]
sw $s3, 0($t2)# matriz[2][4] = matriz[1][3] + matriz[2][2]


.data

l0: .word 1,2,3,4,5
l1: .word 1,2,3,4,5
l2: .word 1,2,3,4,5
l3: .word 1,2,3,4,5
l4: .word 1,2,3,4,5
col: .word l0,l1,l2,l3,l4