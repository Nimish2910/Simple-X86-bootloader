BITS 16                ; Specify 16-bit mode
org 0x7C00             ; Origin where BIOS loads the bootloader

start:
    mov si, msg        ; Load the address of the message into the SI register

print_char:
    lodsb              ; Load the next byte of the string into AL and increment SI
    cmp al, 0          ; Check if the current character is null (end of the string)
    je done            ; If null, jump to the "done" section
    mov ah, 0x0E       ; BIOS teletype function to display a character
    int 0x10           ; Call BIOS interrupt to print the character
    jmp print_char     ; Repeat the process for the next character

done:
    hlt                ; Halt the CPU

msg db "Hello, Bootloader World!", 0  ; The string to display, terminated by null

times 510-($-$$) db 0  ; Pad the bootloader to 510 bytes
dw 0xAA55              ; Boot signature required for BIOS to recognize the bootloader


