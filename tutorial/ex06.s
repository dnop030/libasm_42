global _start

section .text
_start:
	call func
	mov rax,60
	syscall

func:
	mov rdi, 42

	;1st solution
	;pop rax
	;jmp rax

	;2nd solution
	ret
