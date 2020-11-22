include macros2.asm

.MODEL LARGE ;Modelo de Memoria
.386 ;Tipo de Procesador
.STACK 200h ;Bytes en el Stack

.DATA
    _5  dd  5.0
    _2  dd  2.0


.CODE

start:
    MOV EAX,@DATA
    MOV DS,EAX
    MOV ES,EAX

FILD 5
FILD 2
FADD
FSTP sum
    MOV EAX, 4C00h
    INT 21h

    END start