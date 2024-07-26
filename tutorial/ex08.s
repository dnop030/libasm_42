;nasm -f elf64 ex08.s -o ex08.o
;gcc -m64 ex08.o -o ex08

section .data
	msg db "Testing %i...", 0x0a, 0x00

section .text
global main

extern printf

main:
	push rbp
	mov rbp,rsp
	lea rdi,[rel msg]		;load 1st param to printf need to use lea due to PIE
	mov rsi,123
	call printf wrt ..plt
	mov rax,0
	mov rsp,rbp
	pop rbp
	ret
