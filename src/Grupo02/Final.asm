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
	_str1	db	"Prueba.txt LyC Tema 1!",'$',22 dup(?)
	_str2	db	"Ingrese un valor entero: ",'$',25 dup(?)
	_0	dd	0.0
	_02_5	dd	2.5
	_0xA2B0	dd	41648.0
	_2	dd	2.0
	_1	dd	1.0
	_0_342	dd	0.342
	@aux0	dd	?
	@constanteAContar	dd	?
	@contador	dd	?
	_256	dd	256.0
	_0b10	dd	2.0
	_52	dd	52.0
	_4	dd	4.0
	_str3	db	"La suma es: ",'$',12 dup(?)
	_str4	db	"actual es mayor que 2 ",'$',22 dup(?)
	_0b111010	dd	58.0
	_str5	db	"no es mayor que 2",'$',17 dup(?)


.CODE

start:
	MOV EAX,@DATA
	MOV DS,EAX
	MOV ES,EAX

	DisplayString _str1
	newline 1
	DisplayString _str2
	newline 1
	GetFloat actual
	FLD _0
	FSTP contador
	FLD _02_5
	FLD _0xA2B0
	FADD
	FSTP suma
ET_aux0:
	FLD contador
	FLD _2
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	JA ET_aux5
	FLD contador
	FLD _1
	FADD
	FSTP contador
	FLD contador
	FLD _0_342
	FDIV 
	FLD contador
	FSTP @aux0
	FLD actual
	FLD contador
	FMUL 
	FSTP @constanteAContar
	FLD _0
	FSTP @contador
	FLD _256
	FLD @constanteAContar
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	JNE ET_aux1
	FLD _1
	FLD @contador
	FADD
	FSTP @contador
ET_aux1:
	FLD _0b10
	FLD @constanteAContar
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	JNE ET_aux2
	FLD _1
	FLD @contador
	FADD
	FSTP @contador
ET_aux2:
	FLD _52
	FLD @constanteAContar
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	JNE ET_aux3
	FLD _1
	FLD @contador
	FADD
	FSTP @contador
ET_aux3:
	FLD _4
	FLD @constanteAContar
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	JNE ET_aux4
	FLD _1
	FLD @contador
	FADD
	FSTP @contador
ET_aux4:
	FLD @aux0
	FLD @contador
	FMUL 
	FADD
	FSTP actual
	FLD suma
	FLD actual
	FADD
	FSTP suma
	JMP ET_aux0
ET_aux5:
	DisplayString _str3
	newline 1
	DisplayFloat suma , 2 
	newline 1
ET_aux6:
	FLD actual
	FLD _0b10
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	JBE ET_aux7
	FLD actual
	FLD _0
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	JE ET_aux7
	DisplayString _str4
	newline 1
	JMP ET_aux10
ET_aux7:
ET_aux8:
	FLD actual
	FLD _0b111010
	FXCH
	FCOMP
	FSTSW AX
	SAHF
	JAE ET_aux9
	DisplayString _str5
	newline 1
ET_aux9:
ET_aux10:
	MOV EAX, 4C00h
	INT 21h

	END start