include number.asm
include macros2.asm

.MODEL LARGE ;Modelo de Memoria
.386 ;Tipo de Procesador
.STACK 200h ;Bytes en el Stack

.DATA
	contador	dd	?
	promedio	dd	?
	actual	dd	?
	suma	dd	?
	_Prueba_txt_LyC_Tema_1	db	"Prueba txt LyC Tema 1",'$',21 dup(?)
	_Ingrese_un_valor_enter_	db	"Ingrese un valor enter ",'$',23 dup(?)
	_9	dd	9.0
	_2	dd	2.0
	_1	dd	1.0
	_5	dd	5.0


.CODE

start:
	MOV EAX,@DATA
	MOV DS,EAX
	MOV ES,EAX

DisplayString _Prueba_txt_LyC_Tema_1
DisplayString _Ingrese_un_valor_enter_
GetFloat actual
FLD _9
FILD actual
FLD _2
FMUL 
FLD _1
FDIV 
FADD
FLD _5
FSUB 
FSTP promedio
DisplayFloat actual , 2 
DisplayFloat promedio , 2 
	MOV EAX, 4C00h
	INT 21h

	END start