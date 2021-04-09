MODEL TINY
.DOSSEG
.DATAMSG 
    DB "Hello, World!", 0Dh, 0Ah, '$'

.CODE
.STARTUPMOV 
    BX, 1
    MOV AH, 09h
    MOV DX, OFFSET MSG
    ADD BX, 10
    INT 21h
    MOV AH, 4Ch
    INT 21h
END