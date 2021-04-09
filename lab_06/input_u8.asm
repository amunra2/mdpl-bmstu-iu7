public num
public input_number


DATASEG SEGMENT PARA PUBLIC 'DATA'
    in_msg db 'Input unsigned octal number: $'
    num dw 0
DATASEG ENDS


CODESEG SEGMENT PARA PUBLIC 'CODE'
    assume CS:CODESEG, DS:DATASEG

input_number proc near
    mov ax, DATASEG
    mov ds, ax

    mov ah, 9
    mov dx, OFFSET in_msg
    int 21h

    mov bx, 0

    input_symb_num:
        mov ah, 1
        int 21h

        cmp al, 13 ; if Enter pressed
        je exit_input

        mov cl, al

        mov ax, 8
        mul bx
        mov bx, ax

        sub cl, "0"
        add bx, cx

        jmp input_symb_num


    exit_input:
        mov num, bx

        ret

input_number endp

CODESEG ENDS
END