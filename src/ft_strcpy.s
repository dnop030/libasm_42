;char *ft_strcpy(char * dst, const char * src)

section .text

;Register usage:
;$rdi - ps1	(pointer to input dst)
;$rsi - ps2	(pointer to input src)
;$dl - tmp reg to cpy from src to dst due to cannot mov mem to mem
;$rax - pointer pointed at dst

global ft_strcpy

ft_strcpy:
	mov	rax, rdi			; prep return value
	jmp	loop

incptr:
	inc	rsi					; ps2++
	inc	rdi					; ps1++

loop:
	mov	dl, [rsi]			; cpy byte from src to dst
	mov [rdi], dl			;
	cmp	byte [rsi], 0x00	;
	jne	incptr				; while (*ps1 != NULL)

	inc rdi					; ps1++
	mov byte [rdi], 0x00	; *ps1 = NULL

	ret
