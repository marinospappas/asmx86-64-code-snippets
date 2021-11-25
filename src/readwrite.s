# input output module
# reads and writes integers using standard C library scanf and printf

.data
.align 8
	prompt:	.string "Input a string followed by <Enter> (<Ctrl-D> to exit):\n"

.bss
.align 8
	buffer:	.skip 512

.text
	.global main

######################
# read string function
read_s:
	pushq	%rbx
	pushq	%rdi
	pushq	%rsi

	xorq	%rax, %rax		# system call 0 = read
	movq	%rax, %rdi		# file descriptor 0
	leaq	buffer(%rip), %rsi	# data buffer
	movq	$256, %rdx		# bytes to read
	syscall				# call the kernel

        leaq    buffer(%rip), %rdx
        movb    $0, (%rax,%rdx)		# set string terminator

	popq	%rsi
	popq	%rdi
	popq	%rbx
	ret

#######################
# write string function
write_s:
	pushq	%rbx
	pushq	%rdi
	pushq	%rsi

	leaq	buffer(%rip), %rdi	# data buffer
	call	strlen
	movq	%rax, %rdx		# bytes to write

	movq	$1, %rax		# system call 1 = write
	movq	%rax, %rdi		# file descriptor 1
	leaq	buffer(%rip), %rsi	# data buffer
	syscall				# call the kernel

	popq	%rsi
	popq	%rdi
	popq	%rbx
	ret

############################
# calculate length of string
# params
# 	rdi: address of string
# returns
# 	rax: string length
#
strlen:
	xorq	%rax, %rax		# clear rax (will count the strlen here)
strlen_next:
	cmp	$0, (%rax, %rdi)	# check str char in rdx[rax]
	je	strlen_ret

	inc	%rax
	jmp	strlen_next

strlen_ret:
	ret
	

# main program
main:
	pushq	%rbx
	pushq	%rdi

	# print prompt
	lea	prompt(%rip), %rdi
	xorq	%rax, %rax
	call	printf

read_next:				
	call	read_s			# read a string 

	cmp	$0, %rax
	je	main_exit		# exit loop at end of input

	call	write_s
	jmp	read_next

main_exit:
	popq	%rdi
	popq	%rbx
	ret				# bye bye

