global _start

_start:
	call func
	mov	rax,60
	mov	rdi,0
	syscall

func:
	push rbp				;preserve rbp bef using
	mov rbp,rsp				;save base pointer
	sub rsp,2				;allocate memory
	mov [rsp], byte 'H'		;
	mov [rsp+1], byte 'i'	;
	mov rax,1				;sys_wr
	mov rdi,1				;stdout Fd
	mov rsi,rsp				;byte to wr
	mov rdx,2				;number of byte to wr
	syscall
	mov rsp,rbp				;free memory
	pop rbp
	ret
