global _start

section .data
	msg db "Hello, world!", 0x0a
	len equ $ - msg

section .text
_start:
	mov rax, 1		; sys_write system call
	mov rdi, 1		; stdout Fd
	mov rsi, msg	; byte to wr
	mov rdx, len	; number of byte to wr
	syscall			; perform system call
	mov rax, 60		; sys_exit system call
	mov rdi, 0		; exit status is 0
	syscall
