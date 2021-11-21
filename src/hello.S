    .global  _start

    .text
_start:
    mov     $1, %rax
    mov     $1, %rdi
    mov     $hello, %rsi
    mov     $13, %rdx
    syscall

    mov     $60, %rax
    xor     %rdi, %rdi
    syscall

hello:
    .ascii "Hello, world\n"
