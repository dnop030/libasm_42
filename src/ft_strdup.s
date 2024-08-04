;char *ft_strdup(const char *s)

section .text

;Register usage:

global ft_strdup

extern malloc, ft_strlen, ft_strcpy

ft_strdup:
	mov		r10, rdi			; keep ptr input str
	call	ft_strlen			; hope that rdi is pass to ft_strlen
	inc		rax					; inc for NULL str at the end of dst
	mov		rdi, rax			; assign strlen for malloc memory
	call	malloc wrt ..plt
	cmp		rax, 0x00			;
	je		return

	mov		r11, rax			; keep ptr of new str from malloc
	mov		rdi, r11			; assign dst pointer of str
	mov		rsi, r10			; assign src pointer of str
	call	ft_strcpy
	mov		rax, r11			; prep return value

return:

	ret
