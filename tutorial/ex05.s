global _start

section .text
_start:
	sub rsp,4				;allocate 4 bytes
	mov [rsp], byte 'H'		;assign allocated memory
	mov [rsp+1], byte 'e'	;assign allocated memory
	mov [rsp+2], byte 'y'	;assign allocated memory
	mov [rsp+3], byte '!'	;assign allocated memory

	mov rax,1				;sys_wr
	mov rdi,1				;stdout Fd
	mov rsi,rsp				;pointer to byte to wr
	mov rdx,4				;number of byte to wr
	syscall				;perform syscall

	mov rax,60				;sys_exit
	mov rdi,0				;exit status
	syscall
