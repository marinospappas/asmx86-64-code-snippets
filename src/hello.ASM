;
;  This program runs in 32-bit protected mode.
;  gcc links the standard-C library by default

;  build: nasm -f elf -F stabs name.asm
;  link:  gcc -o name name.o
;
; In 64-bit long mode you can use 64-bit registers (e.g. rax instead of eax, rbx instead of ebx, etc..)
; Also change "-f elf " for "-f elf64" in build command.
;
        global  main                                ;main must be defined as it being compiled against the C-Standard Library
        extern  printf                               ;declares use of external symbol as printf is declared in a different object-module.
                                                           ;Linker resolves this symbol later.

segment .data                                       ;section for initialized data
	string db 'Hello world!', 0Ah, 0h           ;message string with new-line char (10 decimal) and the NULL terminator
                                                    ;string now refers to the starting address at which 'Hello, World' is stored.

segment .text
main:
        push    string                              ;push the address of first character of string onto stack. This will be argument to printf
        call    printf                              ;calls printf
        add     esp, 4                              ;advances stack-pointer by 4 flushing out the pushed string argument
        ret                                         ;return
