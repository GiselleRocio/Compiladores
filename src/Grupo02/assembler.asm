include number.asm
include macros2.asm

.MODEL LARGE ;Modelo de Memoria
.386 ;Tipo de Procesador
.STACK 200h ;Bytes en el Stack

.DATA
	_contador	dd	?
	_promedio	dd	?
	_actual	dd	?
	_suma	dd	?
	Prueba.txt_LyC_Tema_1!	db	"Prueba.txt LyC Tema 1!",'$',22 dup(?)
	Ingrese_un_valor_enter_	db	"Ingrese un valor enter ",'$',23 dup(?)
	_0	dd	0.0
	_02.5	dd	2.5
	_0xA2B0	dd	41648.0
	_92	dd	92.0
	_1	dd	1.0
	_0.342	dd	0.342
	@constanteAContar	dd	?
	@contador	dd	?
	_256	dd	256.0
	_0b10	dd	2.0
	_52	dd	52.0
	_4	dd	4.0
	La_suma_es:_	db	"La suma es: ",'$',12 dup(?)
	actual_es_mayor_	db	"actual es mayor ",'$',16 dup(?)
	_0b111010	dd	58.0
	no_es_mayor_que_2	db	"no es mayor que 2",'$',17 dup(?)



