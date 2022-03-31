	LIST		P=P16F887				;Seleccionamos el micrcontrolador a utlizar.
	#Include 	<P16F887.inc>			;Declaramos la libreria del PIC.

Inicio

	BANKSEL		PORTA					;Limpiamos todos los puertos del microcontrolador.
	CLRF		PORTA
	CLRF		PORTB
	CLRF		PORTC
	CLRF		PORTD
	CLRF		PORTE

	BANKSEL		ANSEL
	MOVLW		b'00000000'
	MOVWF		ANSEL
	MOVWF		ANSELH

	BANKSEL		TRISB
	MOVLW		b'11111111'				;Declaramos el puerto B como entradas digitales.
	MOVWF		TRISB
	MOVLW		b'11111000'				;Declaramos los últimos 3 bits del puerto C como salidas digitales.
	MOVWF		TRISC

	BANKSEL		PORTC					;Declaramos variables y les asignamos un registro.
	DATOA 		EQU 0X20
	DATOB 		EQU 0X21

BUCLE

	MOVF		PORTB,W					;Cargar el valor de PORTB a W
	MOVWF		DATOA					;Cargar el valor de W a la variable DATOA y DATOB
	MOVWF		DATOB
	SWAPF		DATOB					;Intercambiar los nibles de la variable DATOB
	MOVLW		b'00001111'
	ANDWF		DATOA,1					;Usar la operación lógica AND para dejar únicamente los nibles correspondientes en cada variable.
	ANDWF		DATOB,1					

	MOVF		DATOA,W
	SUBWF		DATOB,W					;Restar el dato A al dato B

	

	BTFSS		STATUS,Z
	GOTO		COMPARACION1
	GOTO		IGUALES

COMPARACION1							;Si DATOA < DATOB enciende RC0

	BTFSC		STATUS,C
	GOTO		COMPARACION2
	BCF			PORTC,1
	BCF			PORTC,2
	BSF			PORTC,0
	GOTO		BUCLE

COMPARACION2							;Si DATOA > DATOB enciente RC2

	BCF			PORTC,0
	BCF			PORTC,1
	BSF			PORTC,2
	GOTO		BUCLE

IGUALES									;Si DATOA = DATOB enciente RC1

	BCF			PORTC,0
	BCF			PORTC,2
	BSF			PORTC,1
	GOTO		BUCLE

	END