.text
.eqv readDoubleService 7
.eqv printStringService 4
.eqv printDoubleService 3
.eqv N 8

.macro imprimeString(%endString)
            la      $a0, %endString
            li      $v0, printStringService
            syscall
.end_macro

.macro imprimeDouble(%endDouble)
            l.d      $f12, %endDouble
            li      $v0, printDoubleService
            syscall
.end_macro

init:

	jal main

	li $v0, 10
	syscall


taylor:

	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	li $s0, 0
	mtc1.d $s0, $f0
	
	
	for_serie_taylor:
	
	beq $s0, N, fim_for_serie_taylor
	s.d $f0, n_atual
	imprimeString(nString)
	imprimeDouble(n_atual)
	mov.d $f12, $f0
	
	#f12 será usado para passar como parâmetro e f14 para retorno
	
	
	# (2n)!
	move $a0, $s0
	mul $a0, $a0, 2
	
	jal fatorial
	
	mov.d $f2, $f14

		
	# x^(2n)
	move $a0, $s0
	mul $a0, $a0, 2
	jal potencia
	
	mov.d $f4, $f14 #valor de x na potência
	
	div.d $f4, $f4, $f2
	
	#descobre se N é impar ou par
	move $a0, $s0
	jal impar_ou_par
	move $t0, $v0
	
	#se t0 = 1, é impar, se igual 0, é par
	beqz $t0, nao_nega_o_valor
	
	neg.d $f4, $f4
	
	nao_nega_o_valor:
	
	l.d $f6, resultado
	add.d $f6, $f6, $f4
	s.d $f6, resultado
	l.d $f6, d0
	imprimeString(resultadoString)
	imprimeDouble(resultado)
	
	addi $s0, $s0, 1
	
	mov.d $f12, $f0
	jal incrementa_f
	mov.d $f0, $f14
	s.d $f0, n_atual
	
	j for_serie_taylor
	
	fim_for_serie_taylor:
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addiu $sp, $sp, 12
	
	jr $ra
	
	
incrementa_f:

	mov.d $f6, $f12
	
	l.d $f8, d1
	
	add.d $f6, $f6, $f8
	
	mov.d $f14, $f6
	l.d $f6, d0
	l.d $f8, d0
	
	jr $ra
	

fatorial:

	#n_atual está em f12
	#2.N
	mov.d $f6, $f12
	l.d $f8, d2
	mul.d $f6, $f6, $f8
	
	l.d $f8, d1 #valor inicial 1
	l.d $f10, dn1 #valor de decremento -1

	move $t0, $a0 #move para t0 o numero que quero como fatorial para realizar o for
	
	bnez $t0, for_fatorial #se 2.N != 0 realiza o procedimento de fatorial, se não, seta resultado como 1
	l.d $f14, d1
	j fim_fatorial
	
	for_fatorial:
	beq $t0, 1, fim_for_fatorial

	mul.d $f8, $f8, $f6
	add.d $f6, $f6, $f10
	
	addi $t0, $t0, -1

	j for_fatorial
	fim_for_fatorial:
	mov.d $f14, $f8
	fim_fatorial:
	l.d $f6, d0
	l.d $f8, d0
	l.d $f10, d0
	

	jr $ra
	

potencia:

	l.d $f6, radianos #seta em f6 o angulo em radianos
	mov.d $f8, $f6
	
	move $t0, $a0 #move para t0 o numero do expoente
	bnez $t0 for_potencia
	l.d $f14, d1
	j fim_potencia
	
	for_potencia:

	beq $t0, 1, fim_for_potencia

	mul.d $f8, $f8, $f6

	addi $t0, $t0, -1
	j for_potencia

	fim_for_potencia:
	
	mov.d $f14, $f8
	fim_potencia:
	l.d $f6, d0
	l.d $f8, d0

	jr $ra
	
impar_ou_par:
	
	move $t0, $a0
	
	la $t1, last_bit
	lw $t1, 0($t1)
	
	and $t2, $t0, $t1
	
	move $v0, $t2
	
	jr $ra





ler_angulo:
	la $t0, radianos
	
	li $v0, readDoubleService
	syscall
	
	s.d $f0, ($t0)
	
	jr $ra
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	imprimeString(pedindo_angulo)
	jal ler_angulo
	imprimeDouble(radianos)
	jal taylor
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	

.data

radianos: .double 0.00
resultado: .double 0.00
n_atual: .double 0.00
pedindo_angulo:     .asciiz  "Diga, em radianos, o valor do angulo: \n"
nString: .asciiz "\nN atual: \n"
resultadoString: .asciiz "\nresultado: \n"
last_bit: .word 0x00000001

d0: .double 0.00
d2: .double 2.00
d1: .double 1.00
dn1: .double -1.00

