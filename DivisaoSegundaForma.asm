.text
.eqv printStringService 4
.eqv printIntService 1

.macro imprimeString(%endString)
            la      $a0, %endString
            li      $v0, printStringService
            syscall
.end_macro

.macro imprimeInt(%endInt)
            la      $a0, %endInt
            lw	    $a0, 0($a0)
            li      $v0, printIntService
            syscall
.end_macro

# Programa principal
    main:
        # Carregar os valores de x e y nos registradores
        lw $a0, x
        lw $a1, y

        # Chamar o procedimento de divisão
        jal div32
        move $t0, $v0
        move $t1, $v1
        sw $t0, quociente
        sw $t1, resto
	imprimeString(quocienteString)
	imprimeInt(quociente)
	imprimeString(restoString)
	imprimeInt(resto)	
        
        #encerrando
        li $v0, 10       # Código do sistema para encerrar o programa
        syscall
# Procedimento de divisão
div32:
	addiu $sp, $sp, -20
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $ra, 0($sp)
	
	move $s0, $a0 #resto_low = x
	li $s4, 0 #resto_high
	move $s1, $a1 #divisor = y
	
	srl $t0, $s0, 31	# pega MSB do resto_low
	
	sll $s4, $s4, 1		# shifta high do resto
	or $s4, $s4, $t0	# faz or lógico para setar LSB do high para MSB do low
	sll $s0, $s0, 1 	# shifta low do resto
	
	#LOOP 32 vezes
	li $s3, 0
	loop:
        # Verifica se i < 31
        bge $s3, 32, end_loop
        
        bltu $s4, $s1, resto_negativo	# checa se resto é menor que divisor. Se for shifta resto para esquerda e lsb=0, se não, resto = resto - divisor e shifta resto para esquerda e lsb=1
        
        resto_positivo:
        	subu $s4, $s4, $s1      # resto = resto + (-divisor)
        
        	srl $t0, $s0, 31	# pega MSB do resto_low
	
		sll $s4, $s4, 1		# shifta high do resto
		or $s4, $s4, $t0	# faz or lógico para setar LSB do high para MSB do low
		sll $s0, $s0, 1 	# shifta low do resto
		
		ori $s0, $s0, 1         #seta LSB = 1
		
		j fim_if
        
        resto_negativo:
        	srl $t0, $s0, 31	# pega MSB do resto_low
	
		sll $s4, $s4, 1		# shifta high do resto
		or $s4, $s4, $t0	# faz or lógico para setar LSB do high para MSB do low
		sll $s0, $s0, 1 	# shifta low do resto
	
	fim_if:
        # Incrementa i
        addi $s3, $s3, 1
        # Salta de volta para o início do loop
        j loop
    end_loop:
    srl $s4, $s4, 1 #shift para direita do resto_high
    #por fim
    move $v0, $s0 # quociente
    move $v1, $s4 # resto
   #retomando pilha
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s3, 12($sp)
    lw $s4, 16($sp)
    lw $ra, 0($sp)
    addiu $sp, $sp, 20
#retornando à main
    jr $ra
	


.data
    y: .word 0x90357274
    x: .word 0x12341234
    quociente: .word 0
    resto: .word 0
    quocienteString: .asciiz "\nO quociente eh: "
    restoString: .asciiz "\nO resto eh: "