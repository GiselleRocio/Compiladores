include number.asm
include macros2.asm

.MODEL LARGE ;Modelo de Memoria
.386 ;Tipo de Procesador
.STACK 200h ;Bytes en el Stack

.DATA
	cont	dd	?
	actual	dd	?
	_0	dd	0.0
	_12	dd	12.0
	_2	dd	2.0
	_9	dd	9.0
	_1	dd	1.0


.CODE

start:
	MOV EAX,@DATA
	MOV DS,EAX
	MOV ES,EAX

	FLD _0
	FSTP cont
	FLD _12
	FSTP actual
ET_aux0:
	FLD cont
	FLD _2
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	FFREE
	JAE 	FLD  
	FLD actual
	FLD _12
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	FFREE
	JBE ET_aux4
ET_aux4:
	FLD cont
	FLD _9
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	FFREE
	JA ET_aux2
	FLD sarasa
	FLD _9
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	FFREE
	JA ET_aux3
ET_aux2:
	FLD cont
	FLD _1
	FADD
	FSTP cont
	JMP ET_aux1
ET_aux3:
	JMP ET_aux0
ET_aux4:
	MOV EAX, 4C00h
	INT 21h

	END start