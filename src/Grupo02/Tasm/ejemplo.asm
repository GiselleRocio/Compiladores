include macros2.asm
include number.asm
.MODEL LARGE
.386
STACK 200h

.DATA
_cte3 dd 3.0
_cte04 dd 0.4
_cte32 dd 3.2
_cte4 dd 4.0

a dd ?
b dd ?

T_Read db "Ingrese numero: ", '$', 16 dup (?)
.CODE
start:
MOV EAX, @DATA
MOV DS, EAX
MOV ES, EAX

MOV dx, Offset T_Read 
MOV ah,9
int 21h
GetInteger b

FILD b
FLD _cte3
; suma
    FADD
    FLD _cte04
; suma
    FADD
    FLD _cte32
; suma
    FADD                ; 1 = 1 + 0 pop
    FLD _cte4
 
; division
    FDIV                ;1 = 1/0 pop
;asig
    FSTP a                ; FSTP i  -> i = pop

    DisplayFloat a,2
 
    MOV EAX, 4C00h ; termina la ejecuón.
    INT 21h
 
    END start;
    ; 