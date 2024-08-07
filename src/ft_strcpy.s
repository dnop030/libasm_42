;char *ft_strcpy(char * dst, const char * src)

section .text

;Register usage:
;$rdi - ps1	(pointer to input dst)
;$rsi - ps2	(pointer to input src)
;$dl - tmp reg to cpy from src to dst due to cannot mov mem to mem
;$rax - pointer pointed at dst

global ft_strcpy

ft_strcpy:
	mov	rax, rdi			; prep output

loop:
	mov	byte dl, [rsi]		; copy from src to dst
	mov [rdi], dl			;

	inc	rdi					; inc ptr
	inc	rsi					;

	cmp byte dl, 0x00		; if (*src != NULL)
	jne	loop				;

	ret
