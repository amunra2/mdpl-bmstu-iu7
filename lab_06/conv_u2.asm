public convert_ubin

extrn num: word


DATASEG SEGMENT PARA PUBLIC 'DATA'
    out_msg db 'Converted number: $'
    binnum db 16 dup('0'), '$'

    mask2 dw 1
DATASEG ENDS


CODESEG SEGMENT PARA PUBLIC 'CODE'
    assume CS:CODESEG, DS:DATASEG

to_ubin:
    ; Var1 (ready)

    ; mov bx, num

    ; mov cx, 16

    ; loop_out:
    ;     mov ax, '0' 
    ;     shl bx, 1

    ;     adc al, ah

    ;     mov ah, 2
        
    ;     mov dl, al
    ;     int 21h

    ;     loop loop_out

    
    ; Var2

    mov ax, num
    mov bx, 15

    c_ubin:
        mov dx, ax

        and dx, mask2
        add dl, '0'

        mov binnum[bx], dl

        sar ax, 1

        dec bx

        cmp bx, -1
        jne c_ubin

    ret


print_ubin:

    mov cx, 16
    mov bx, 0

    loop_out: 
        mov ah, 2

        mov dl, binnum[bx]

        inc bx

        int 21h
        
        loop loop_out

    ret

; Var 2 end




convert_ubin proc near
    mov dx, OFFSET out_msg
    mov ah, 9
    int 21h

    call to_ubin

    call print_ubin

    ret

convert_ubin endp

CODESEG ENDS
END