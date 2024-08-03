;nasm -f elf64 ex10.s -o ex10.o
;ld ex10.o -o ex10 -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 -L/usr/lib/x86_64-linux-gnu

;nasm -f elf64 -g ex10.s -o ex10.o
;ld -g ex10.o -o ex10 -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2 -L/usr/lib/x86_64-linux-gnu

section .data
fmt db "Error number: %d", 10, 0

section .bss
errnum resq 1

section .text
global _start

extern __errno_location, printf

_start:
	; Call a system function that sets errno (e.g., open a non-existing file)
	; Here we use an invalid system call for demonstration purposes
	mov eax, 9999			; Invalid syscall number
	syscall					; Trigger the syscall

	; Call __errno_location to get the address of errno
	call __errno_location wrt ..plt

	; Store the pointer to errno in errnum
	mov [errnum], rax

	; Load the value of errno
	mov rax, [rax]

	; Print the errno value using printf
	mov rsi, rax			; Argument for printf (errno value)
	lea rdi, [rel fmt]		; Format string
	xor eax, eax			; Clear rax for variadic functions
	call printf wrt ..plt

	; Exit the program
	mov eax, 60				; Syscall number for exit
	xor edi, edi			; Exit code 0
	syscall
