;nasm -f elf64 ex09.s -o ex09.o

section .data
	msg db "ResAsm: %i", 0x09, 0x00

section .text

global add42

extern printf

add42:
	push rbp
	mov rbp, rsp
	mov rax, rdi
	add rax, 42
	mov rsp, rbp
	pop rbp
	ret
