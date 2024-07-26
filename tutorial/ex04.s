global _start

section .data
	addr db "yellow"

section .text
_start:
	mov [addr], byte 'H'
	mov [addr+5], byte 0x0A
	mov rax,1				;sys_wr
	mov rdi,1				;stdout Fd
	mov rsi,addr			;byte to wr
	mov rdx,6				;number of byte to write
	syscall					;perform system call

	mov rax,60				;sys_exit
	mov rdi,0				;exit status 0
	syscall				;perform system call
