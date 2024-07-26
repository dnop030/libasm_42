global _start

_start:
	mov rcx, 97		;set ecx to
	mov rdi, 42		;set exit status is 42
	mov rax, 60		;sys_exit
	cmp rcx, 98		;compare ecx to 98
	jl skip			;jump to "skip" label if ecx less
	mov rdi, 13		;exit status is 13

skip:
	syscall
