.data
    mensaje1: .asciiz "Ingresa un número: "
    respuesta: .asciiz "\nEl factorial es: "
    tiempoInicial: .word 0
    mensajeDelTiempo: .asciiz "\nTiempo de ejecucion: "
    error_mensaje: .asciiz "\nError: El número ingresado es negativo.\n"

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
    
    # Validar entrada no negativa
    bltz $t1, errorMensaje
    
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
    sub $a0, $t0, $t1
    li $v0, 1
    syscall

    # Termina el programa
    li $v0, 10
    syscall

# Función para calcular el factorial
calcular_factorial:
    li $v0, 1  # Inicializa el resultado en 1

multiplicacion:
    beq $a0, $zero, retorno  # Si n == 0, termina la función
    mul $v0, $v0, $a0  # Multiplica el resultado por n
    addi $a0, $a0, -1  # Decrementa n
    j multiplicacion

retorno:
    jr $ra

errorMensaje:
    li $v0, 4
    la $a0, error_mensaje
    syscall
    li $v0, 10
    syscall
