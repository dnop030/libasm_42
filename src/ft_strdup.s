;char *ft_strdup(const char *s)

section .text

;Register usage:
;r12 - ipptrstr keep ptr of input string
;r13 - tmpptr keep ptr of new str

global ft_strdup

extern malloc
extern ft_strlen
extern ft_strcpy

ft_strdup:

	mov		r12, rdi			; keep ptr input str
	call	ft_strlen			; hope that rdi is pass to ft_strlen
	inc		rax					; inc for NULL str at the end of dst

	mov		rdi, rax			; assign strlen for malloc memory
	call	malloc wrt ..plt
	cmp		rax, 0x00			; if (malloc == NULL)
	je		return				; return 0

	mov		r13, rax			; keep ptr of new str from malloc
	mov		rdi, r13			; assign dst pointer of str
	mov		rsi, r12			; assign src pointer of str
	call	ft_strcpy
	mov		rax, r13			; prep return value

return:

	ret
