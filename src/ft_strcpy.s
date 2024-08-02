;char *strcpy(char *restrict dst, const char *restrict src)

section .text

;Register usage:
;$rdi - ps1	(pointer to input dst)
;$rsi - ps2	(pointer to input src)
;$rax - pointer pointed at NULL of  dst

global ft_strcpy

ft_strcpy:
	jmp	loop

incptr:
	inc	rsi					; ps2++
	inc	rdi					; ps1++

loop:
	mov	rax, [rsi]			; cpy byte from src to dst
	mov [rdi], rax			;
	cmp	byte [rsi], 0x00	;
	jne	incptr				; while (*ps1 != NULL)

	inc rdi					; ps1++
	mov byte [rdi], 0x00	; *ps1 = NULL
	mov	rax, rdi			; prep return value

	ret
