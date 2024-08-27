;char *ft_strdup(const char *s)

section .text

;Register usage:
;r12 - ipptrstr keep ptr of input string
;r13 - tmpptr keep ptr of new str

global ft_strdup

extern malloc
extern ft_strlen
extern ft_strcpy
extern __errno_location

ft_strdup:

	mov		r12, rdi			; keep ptr input str
	call	ft_strlen			; hope that rdi is pass to ft_strlen
	inc		rax					; inc for NULL str at the end of dst

	mov		rdi, rax			; assign strlen for malloc memory
	call	malloc wrt ..plt
	cmp		rax, 0x00			; if (malloc == NULL)
	je		set_errno			; return 0

	mov		r13, rax			; keep ptr of new str from malloc
	mov		rdi, r13			; assign dst pointer of str
	mov		rsi, r12			; assign src pointer of str
	call	ft_strcpy
	mov		rax, r13			; prep return value
	jp		return

set_errno:
	push	rax								; store err in stack
	call	__errno_location wrt ..plt		; call errno location
	pop		rdx								; pop err from stack
	neg		rdx								; reverse value from neg to pos
	mov		byte [rax], dl					; wr err to proper location
	mov		rax, 0							; set return status

return:

	ret
