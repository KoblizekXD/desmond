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
    mov si, %1
    mov ah, 0x0E
    mov al, [si]
    .printc:
        int 0x10
        inc si
        mov al, [si]
        cmp al, 0
        jne .printc
%endmacro

write_line haha, "Hello world!"

hlt

times 510-($-$$) db 0
dw 0xAA55