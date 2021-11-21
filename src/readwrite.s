# input output module
# reads and writes integers using standard C library scanf and printf

.data
.align 8
	fmt_wi:	.string "value: %d\n"
	fmt_ri:	.string "%d\n"
	fmt_prompt:	.string "Input value followed by <Enter> and <Ctrl>D: "
	value:	.quad  0

.text
	.global main

# read integer function
read_i:
	pushq	%rbx
	pushq	%rdi			# save address of variable

	lea	fmt_prompt(%rip), %rdi	# print prompt
	xor	%eax, %eax
	call	printf

	popq	%rsi	          	# retrieve address of varaible rsi
	lea	fmt_ri(%rip), %rdi	# fmt string in rdi
	xor	%eax, %eax
	call	scanf
	popq	%rbx
	ret

# write integer function
write_i:
	pushq	%rbx
	movq	%rdi, %rsi		# value to be printed was in rdi - must be saved in rsi
	lea	fmt_wi(%rip), %rdi	# fmt string in rdi
	xor	%eax, %eax
	call	printf
	popq	%rbx
	ret	

# main program
main:
	lea	value(%rip), %rdi	# adress of the variable to be read
	pushq	%rbx
	call	read_i
	popq	%rbx

	movq	value(%rip), %rax
	movq	$5, %rbx
	imulq	%rbx
	movq	%rax, value(%rip)

	movq	value, %rdi		# value to be printed
	pushq	%rbx
	call	write_i
	popq	%rbx

	ret
