EXTRN read: far
EXTRN string: near


STK SEGMENT PARA STACK 'STACK'		; сегмент стека
    DB 400 DUP (0)					;  
STK ENDS

DATA_SEG SEGMENT PARA COMMON 'DATA'
DATA_SEG ENDS



CODE_SEG SEGMENT PARA PUBLIC 'CODE'
    assume CS:CODE_SEG, DS:DATA_SEG, SS:STK
main:

    call read

    mov cx, 8
    mov bx, 0
    mov ah, 2

    loop1:
        mov dl, byte ptr[string + bx]
        add bx, 1
        int 21h
        loop loop1

    mov ah,4ch						
    int 21h							
CODE_SEG ENDS							 
END main
