
    default rel

    global  main

    extern printf

segment .data
    hello  db "Hello, world",0
    fmt	   db "msg: %s %d",0x0A,0
    value  dq  0x10


segment .text
main:
    push rbx
    lea rdi, [fmt]
    lea rsi, [hello]
    mov rdx, [value]
    call printf

    pop rbx
    ret



