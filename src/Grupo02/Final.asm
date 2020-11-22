include number.asm
include macros2.asm

.MODEL LARGE ;Modelo de Memoria
.386 ;Tipo de Procesador
.STACK 200h ;Bytes en el Stack

.DATA
	actual	dd	?
	_5	dd	5.0
	_2	dd	2.0
	_8	dd	8.0
	_str1	db	"menor a 8",'$',9 dup(?)
	_str2	db	"no menor a 8",'$',12 dup(?)
	_str3	db	"sali del while",'$',14 dup(?)


.CODE

start:
	MOV EAX,@DATA
	MOV DS,EAX
	MOV ES,EAX

	FLD _5
	FLD _2
	FADD
	FSTP actual
ET_cond0:
	FLD actual
	FLD _8
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	FFREE
	JGE ET_else_cond0
	DisplayString _str1
	newline 1
	JMP ET_end_cond0
ET_else_cond0:
	DisplayString _str2
	newline 1
ET_end_cond0:
	DisplayString _str3
	newline 1
	MOV EAX, 4C00h
	INT 21h

	END start