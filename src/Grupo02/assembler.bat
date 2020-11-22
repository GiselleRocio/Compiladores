tasm NUMBERS.ASM
tasm assembler.asm
tlink /3 assembler.OBJ NUMBERS.OBJ /v /s /m
pause
assembler.exe
pause
del assembler.obj
del assembler.map
del numbers.obj
del assembler.exe