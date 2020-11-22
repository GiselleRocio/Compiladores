include number.asm
include macros2.asm

.MODEL LARGE ;Modelo de Memoria
.386 ;Tipo de Procesador
.STACK 200h ;Bytes en el Stack

.DATA
	actual	dd	?
	_5	dd	5.0
	_2	dd	2.0
	_0	dd	0.0
	_1	dd	1.0
	_str1	db	"sali del while",'$',14 dup(?)


.CODE

start:
	MOV EAX,@DATA
	MOV DS,EAX
	MOV ES,EAX

	FLD _5
	FLD _2
	FADD
	FSTP actual
ET_while0:
	FLD actual
ET_cond0:
	FLD _0
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	JLE ET_end_cond0
	DisplayFloat actual , 2 
	newline 1
	FLD actual
	FLD _1
	FSUB 
	FSTP actual
	JMP ET_while0:
	DisplayString _str1
	newline 1
	MOV EAX, 4C00h
	INT 21h

	END start