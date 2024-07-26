global _start

_start:
	mov	rax,60	; sys_exit
	mov	rdi,42	; set exit status
	sub	rdi,20	; sub exit status
	syscall
