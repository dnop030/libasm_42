
;ssize_t write(int fd, const void buf[count], size_t count)

section .text

global ft_write
ft_write:
	push rbp		;prologue
	mov rbp, rsp	;prologue

	mov rax, 1
	syscall

	mov rsp, rbp	;epilogue
	pop rbp			;epilogue
	ret				;epilogue
