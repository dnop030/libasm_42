;int		ft_atoi_base(char *str, char *base)

section .text

;Register usage:
;$rdi - ps1	(pointer to input string1)
;$rsi - ps2	(pointer to input string2)
;$rcx - cnt	(counter to increment pointer of both string)
;$rdx - tmp reg to store *ps2 value in order to find diff
;$rax - diff(ruturn value of differential of string)

global ft_atoi_base
ft_atoi_base:
	mov	r12, rdi
	mov	r13, rsi
	mov	rax, 0
	ret
