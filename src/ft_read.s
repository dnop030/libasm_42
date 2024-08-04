;ssize_t ft_read(int fd, void *buf, size_t count)

section .text

;Register usage:
;$rax - tmp reg to keep return value from syscall and return to main Fn
;$rdx - tmp reg to keep status after push and pop from stack in order to
;		manipulate and send back to __errno_location

global ft_read

extern __errno_location

ft_read:
	push	rbp
	mov		rbp, rsp

	mov		rax, 0
	syscall
	cmp		rax, -1
	jg		return

	; read error
	push	rax							; keep status write to the stack
	call	__errno_location wrt ..plt

	; 1st try
	;pop		word [rax]		; problem is here => cannot pop to mem directly
	;neg		word [rax]

	pop		rdx
	neg		rdx
	mov		byte [rax], dl

	mov	rax, -1


return:

	mov		rsp, rbp
	pop		rbp

	ret
