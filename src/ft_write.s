;ssize_t ft_write(int fd, const void *buf, size_t count)

section .text

global ft_write
ft_write:
	push rbp		;prologue
	mov rbp, rsp	;prologue

	mov rax, 1
	syscall
	cmp	rax, 0x00
	jg	return

	mov	rax, -1

return:

	mov rsp, rbp	;epilogue
	pop rbp			;epilogue
	ret				;epilogue
