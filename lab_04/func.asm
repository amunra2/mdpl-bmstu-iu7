PUBLIC read
PUBLIC string


STK SEGMENT PARA STACK 'STACK'		; сегмент стека
    DB 400 DUP (0)					;  
STK ENDS



DATA_SEG SEGMENT PARA COMMON 'DATA'
DATA_SEG ENDS


SEG_CODE SEGMENT PARA PUBLIC 'CODE'
    assume CS:SEG_CODE, DS:DATA_SEG, SS:STK

read proc far
    mov ax, DATA_SEG
    mov dx, ax
    mov ah, 10
    mov dx, OFFSET max_size
    int 21h

    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

    ret
read endp
SEG_CODE ENDS
END