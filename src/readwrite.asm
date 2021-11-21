
	default rel

	global  main

	extern printf
	extern scanf

section .data
	fmt_wi:	db "value: %d",0x0A,0
	fmt_ri:	db "%d",0x0A,0
	value:	dq  0

section .text

; read integer function
read_i:
	push	rbx
	lea	rdi, [fmt_ri]
	lea	rsi, [value]
	xor	eax, eax
	call	scanf
	mov	rax, [value]
	pop	rbx
	ret

; write integer function
write_i:
	push	rbx
	lea	rdi, [fmt_wi]
	mov	rsi, [value]
	xor	eax, eax
	call	printf
	pop	rbx
	ret	

; main program
main:
	push	rbx
	call	read_i
	pop	rbx

	push	rbx
	call	write_i
	pop	rbx

	ret
