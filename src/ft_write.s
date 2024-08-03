;ssize_t ft_write(int fd, const void *buf, size_t count)

section .text

;Register usage:
;$rax - tmp reg to keep return value from syscall and return to main Fn

global ft_write

extern __errno_location

ft_write:
	push rbp		;prologue
	mov rbp, rsp	;prologue

	mov rax, 1							; syscall write
	syscall
	cmp	rax, 0x00						; if (write < 0)
	jg	return

	; write error
	push	rax							; keep status write to the stack
	call	__errno_location wrt ..plt
	pop		word [rax]
	neg		word [rax]

	mov	rax, -1

return:

	mov rsp, rbp	;epilogue
	pop rbp			;epilogue
	ret				;epilogue
