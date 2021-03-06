# hello world program
# uses linux system call

.data
hellow: .string "Hello World!\n"
hello_end:
	.set	strlen, hello_end - hellow

.text
.global _start

_start:
	movq	$1, %rax		# system call 1 = write
	movq	%rax, %rdi		# file descriptor 1
	lea	hellow(%rip), %rsi	# data buffer
	movq	$strlen, %rdx		# number of bytes to write
	syscall				# call the kernel

	movq	$60, %rax		# system call 60 = exit
	xorq	%rdi, %rdi		# exit code 0
	syscall				# call the kernel
