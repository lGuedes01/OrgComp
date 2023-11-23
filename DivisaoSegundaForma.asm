.text
# Programa principal
    main:
        # Carregar os valores de x e y nos registradores
        lw $a0, x
        lw $a1, y

        # Chamar o procedimento de divisão
        jal div32

        # Exibir o resultado
        move $a0, $v0
        li $v0, 1
        syscall
        
        #encerrando
        li $v0, 10       # Código do sistema para encerrar o programa
        syscall
# Procedimento de divisão
div32:
	addiu $sp, $sp, -16
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s3, 12($sp)
	sw $ra, 0($sp)
	
	move $s0, $a0 #resto = x
	move $s1, $a1 #divisor = y
	
	sll $s0, $s0, 1 #shift para esquerda 1 vez
	sll $s1, $s1, 4 #shift para esquerda 4 vezes
	
	#LOOP 5 vezes
	li $s3, 0
	loop:
        # Verifica se i < 4
        bge $s3, 4, end_loop

        # Corpo do loop (coloque aqui o código a ser repetido)
	neg $t0, $s1 #$to = - divisor
	add $s0, $s0, $t0 #Resto = Resto + (-Divisor)
	#se resto > 0 -> pula, se não, resto = resto + divisor
	bgt $s0, 0, nao_soma
	
	add $s0, $s0, $s1
	sll $s0, $s0, 1
	j fim_if
	
	nao_soma:
	sll $s0, $s0, 1
	add $s0, $s0, 1
	
	fim_if:
		
        # Incrementa i
        addi $s3, $s3, 1

        # Salta de volta para o início do loop
        j loop
    end_loop:
    #por fim
    la $t0, mascara_metade_direita
    lw $t0, 0($t0)
    and $t1, $t0, $s0
    move $v0, $t1
   #retomando pilha
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 0($sp)
    addiu $sp, $sp, 16
#retornando à main
    jr $ra
	


.data
    x: .word 0x90357274
    y: .word 0x12341234
    mascara_metade_esquerda: .word 0x000000f0
    mascara_metade_direita: .word 0x0000000f