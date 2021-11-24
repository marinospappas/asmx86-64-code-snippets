# read a string from stdin
# and convert to integer using own atoi

	.data
	.align 8
	fmt_wi:	.string "int value: %d\n"
	fmt_prompt:	.string "Input a string followed by <Enter> (<Ctrl-D> to exit):\n"
	buffer:	.space 10

.text
	.global main

###########################
# convert string to integer
atoi:
	pushq	%rbx
	pushq	%r8

	xorq	%rax, %rax		# initialise rax to 0 - this will be our integer

	xorq	%r8, %r8		# clear r8
	movzb	(%rdi), %r8		# get the first char
	cmp	$'-', %r8		# check for negative
	je	atoi_l1

	cmp	$'+', %r8		# also check for '+'
	je	atoi_l1

	jmp	atoi_next

atoi_l1:
	inc	%rdi			# point to the next char

atoi_next:	
	movzb	(%rdi), %rbx		# get char
	cmp	$0, %rbx		# check for end of string
	je	atoi_ret

	subq	$'0', %rbx		# ascii to bin value
	cmp	$0, %rbx
	jl	atoi_end		# return if char is < '0'
	cmp	$9, %rbx
	jg	atoi_ret		# return if char is > '9'

	imulq	$10, %rax
	addq	%rbx, %rax		# x10 and add digit
	inc	%rdi			# increment pointer to next char
	jmp	atoi_next

atoi_end:
	cmp	$'-', %r8		# check whether we got a '-' as first char
	jne	atoi_ret

	neg	%rax			# adn negate rax in that case

atoi_ret:
	popq	%r8
	popq	%rbx
	ret

########################
# write integer function
write_i:
	pushq	%rbx
	movq	%rdi, %rsi		# value to be printed was in rdi - must be saved in rsi
	leaq	fmt_wi(%rip), %rdi	# fmt string in rdi
	xorq	%rax, %rax
	call	printf
	popq	%rbx
	ret	

########################
# main program
main:
	pushq	%rdi
	pushq	%rbx
	pushq	%rdx

	# print prompt
	lea	fmt_prompt(%rip), %rdi
	xorq	%rax, %rax
	call	printf

read_next:				# read a string
	movq	$0, %rax		# system call 0 = read
	movq	%rax, %rdi		# file descriptor 0
	leaq	buffer(%rip), %rsi	# data buffer
	movq	$8, %rdx		# bytes to read
	syscall				# call the kernel

	cmp	$0, %rax
	je	main_exit		# exit loop at end of input

        leaq    buffer(%rip), %rdx
        movb    $0, (%rax,%rdx)		# set string terminator

	leaq	buffer(%rip), %rdi	# get string to convert
	call	atoi			# convert to int

	movq	%rax, %rdi		# value to be printed
	call	write_i
	jmp	read_next

main_exit:
	popq	%rdx
	popq	%rbx
	popq	%rdi
	ret				# bye bye
