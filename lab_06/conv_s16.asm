public convert_shex

extrn num: word



DATASEG SEGMENT PARA PUBLIC 'DATA'
    out_msg db 'Converted number: $'
    hexnum db 4 dup('0'), '$'
    sign db ' '

    mask16 dw 15
DATASEG ENDS


CODESEG SEGMENT PARA PUBLIC 'CODE'
    assume CS:CODESEG, DS:DATASEG

to_shex:
    ; Var1 (don't ready, work in a progress...)

    ; mov bx, num

    ; cmp bx, 77777 ; 32767
    ; jbe nosign

    ; mov sign, '-'

    ; sub bx, 1
    ; not bx

    ; nosign:

    ; mov cx, 4

    ; loop_out:
    ;     mov ax, '0'

    ;     mov dx, cx
    ;     mov cl, 4

    ;     shl bx, cl

    ;     mov cx, dx

    ;     adc al, ah

    ;     mov ah, 2
        
    ;     mov dl, al
    ;     int 21h

    ;     loop loop_out

    
    ; Var2

    mov ax, num

    cmp ax, 32767
    jbe nosign

    mov sign, '-'

    sub ax, 1
    not ax

    nosign:

    mov bx, 3

    trans_shex:
        mov dx, ax

        and dx, mask16

        cmp dl, 10
        jb digit

        add dl, 7

        digit:

        add dl, '0'

        mov hexnum[bx], dl

        mov cl, 4
        sar ax, cl

        dec bx

        cmp bx, -1
        jne trans_shex

    ret


print_shex:

    mov cx, 4
    mov bx, 0

    mov dl, sign

    mov ah, 2
    int 21h

    loop_out: 
        mov ah, 2

        mov dl, hexnum[bx]

        inc bx

        int 21h
        
        loop loop_out

    mov sign, ' '

    ret

; Var 2 end




convert_shex proc near
    mov dx, OFFSET out_msg
    mov ah, 9
    int 21h

    call to_shex

    call print_shex

    ret

convert_shex endp

CODESEG ENDS
END
