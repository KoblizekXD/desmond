bits 16
[org 0x7C00]

%define CALL_VIDEO int 0x10

; write_line macro
; Assigns data to specified label and prints the data via tty BIOS interrupt
; Parameters:
; 1) label name
; 2) string value
; Note: Cannot be executed in label(can't db inside label?)
%macro write_line 2
    %1 db %2, 0
    mov si, 0
    mov bh, 0
    mov ah, 0x0E
    mov al, [%1 + si]
    .printc:
        CALL_VIDEO
        inc si
        mov al, [%1 + si]
        cmp al, 0
        jne .printc
        ret
%endmacro

%macro endline 0
    mov ah, 0x03
    CALL_VIDEO
    inc dh
    mov dl, 0
    mov ah, 0x02
    CALL_VIDEO
%endmacro

uwu db "NBiggadclwakdhjaw", 0
mov si, 0
mov bh, 0
mov ah, 0x0E
mov al, [uwu + si]
.printc:
    CALL_VIDEO
    inc si
    mov al, [uwu + si]
    cmp al, 0
    jne .printc
    ret

hlt

times 510-($-$$) db 0
dw 0xAA55