STK SEGMENT PARA STACK 'STACK'		
    DB 150 DUP (0)					 
STK ENDS


DATA_SEG SEGMENT PARA 'DATA'
    msg_rows db 'Input number of rows: $'
    msg_cols db 'Input number of cols: $'
    msg_input db 'Enter matrix: $'
    msg_output db 'Output matrix: $'
    tmp db 0
    rows db 0
    cols db 0
    matrix db 9 * 9 dup(0)
DATA_SEG ENDS


CODE_SEG SEGMENT PARA PUBLIC 'CODE'
    assume CS:CODE_SEG, DS:DATA_SEG, SS:STK

input_symbol:
    mov ah, 1
    int 21h

    ret

new_str:
    mov ah, 2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    ret

space:
    mov ah, 2
    mov dl, ' '
    int 21h
    
    ret

print_msg:
    mov ah, 9
    int 21h

    ret

print_symbol:
    mov ah, 2
    int 21h

    ret


trans_letter:
    mov tmp, dl
    sub tmp, '0'

    cmp tmp, '9'
    ja EXIT

    cmp tmp, '1'
    jb EXIT

    mov dl, tmp

    EXIT:
    ret


input_matrix:
    ; Rows
    mov dx, OFFSET msg_rows

    call print_msg
    call input_symbol

    mov rows, al
    sub rows, '0'
    mov al, rows

    call new_str

    ; Columns
    mov dx, OFFSET msg_cols

    call print_msg
    call input_symbol

    mov cols, al
    sub cols, '0'
    mov al, cols

    call new_str

    ; Matrix
    mov dx, OFFSET msg_input
    
    call print_msg
    call new_str

    mov cl, rows
    mov si, 0

    FOR_ROW_INPUT:
        mov bx, cx
        mov cl, cols

        FOR_COL_INPUT:
            call input_symbol
            mov matrix[si], al
            inc si

            call space

            loop FOR_COL_INPUT
        
        call new_str

        ; Move in memory
        mov ax, 9
        sub al, cols
        add si, ax

        mov cx, bx

        loop FOR_ROW_INPUT

    call new_str

    ret


replace_letters:
    mov cl, rows
    mov si, 0

    FOR_ROW_REPLACE:
        mov bx, cx
        mov cl, cols

        FOR_COL_REPLACE:
            mov dl, matrix[si]
            call trans_letter

            mov matrix[si], dl

            inc si

            loop FOR_COL_REPLACE

        ; Move in memory
        mov ax, 9
        sub al, cols
        add si, ax

        mov cx, bx

        loop FOR_ROW_REPLACE

    ret


output_matrix:
    mov dx, OFFSET msg_output
    call print_msg

    call new_str

    mov cl, rows
    mov si, 0

    FOR_ROW_OUTPUT:
        mov bx, cx
        mov cl, cols

        FOR_COL_OUTPUT:
            mov dl, matrix[si]
            inc si

            call print_symbol
            call space

            loop FOR_COL_OUTPUT

        call new_str

        ; Move in memory
        mov ax, 9
        sub al, cols
        add si, ax

        mov cx, bx

        loop FOR_ROW_OUTPUT

    ret


main:
    mov ax, DATA_SEG
    mov ds, ax

    call input_matrix

    call replace_letters

    call output_matrix

    mov ah, 4Ch						
    int 21h	

CODE_SEG ENDS							 
END main
