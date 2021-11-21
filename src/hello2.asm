
    default rel

    global  main

    extern printf
    extern scanf

section .data
    hello  db "Hello, world",0
    fmt	   db "msg: %s %d",0x0A,0
    fmt1   db "%d",0x0A,0
    value  dq  0x10

section .text
main:
    push rbx
    lea rdi, [fmt1]
    lea rsi, [value]
    xor eax, eax
    call scanf
    pop rbx

    push rbx
    lea rdi, [fmt]
    lea rsi, [hello]
    mov rdx, [value]
    xor eax, eax
    call printf

    pop rbx
    ret



