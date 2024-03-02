.data
    mensaje1: .asciiz "Ingresa un número: "
    respuesta: .asciiz "\nEl factorial es: "
    tiempoInicial: .word 0
    mensajeDelTiempo: .asciiz "\nTiempo de ejecucion: "

.text

main:
    # Imprime el mensaje para ingresar el número
    li $v0, 4
    la $a0, mensaje1
    syscall

    # Lee el número ingresado
    li $v0, 5
    syscall
    move $t1, $v0  # Guarda el número ingresado en $t1
    
    # Iniciar el temporizador
    li $v0, 30
    syscall
    sw $v0, tiempoInicial  # Guarda el tiempo inicial

    # Llama a la función para calcular el factorial
    move $a0, $t1  # Pasa el número ingresado a la función
    jal calcular_factorial
    move $a1, $v0

    # Imprime el resultado
    li $v0, 4
    la $a0, respuesta
    syscall
    move $a0, $a1
    li $v0, 1
    syscall
    
    # Detener el temporizador
    li $v0, 30
    syscall
    move $t0, $v0

    # Imprimir el tiempo total
    li $v0, 4
    la $a0, mensajeDelTiempo
    syscall
	
    lw $t1, tiempoInicial
    li $v0, 1
    sub $a0, $t0, $t1
    syscall

    # Termina el programa
    li $v0, 10
    syscall

# Función para calcular el factorial
calcular_factorial:
    addi $sp, $sp, -4
    sw $ra, ($sp)  # Guarda la dirección de retorno

    li $v0, 1  # Inicializa el resultado en 1

multiplicacion:
    beq $a0, $zero, retorno  # Si n == 0, termina la función
    mul $v0, $v0, $a0  # Multiplica el resultado por n
    addi $a0, $a0, -1  # Decrementa n
    j multiplicacion

retorno:
    lw $ra, ($sp)  # Carga la dirección de retorno
    jr $ra


