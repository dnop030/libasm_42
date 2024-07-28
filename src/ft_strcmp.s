;ft_strcmp.s
;int strcmp(const char *s1, const char *s2)


section .text

;Register usage:
;$rdi - ps1	(pointer to input string1)
;$rsi - ps2	(pointer to input string2)
;$rcx - cnt	(counter to increment pointer of both string)
;$rax - diff(ruturn value of differential of string)

global ft_strcmp
ft_strcmp:

