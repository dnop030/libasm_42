;int		ft_atoi_base(char *str, char *base)
; • Write a function that converts the initial portion of the string pointed by str to int
; representation.
; • str is in a speciﬁc base given as a second parameter.
; • excepted the base rule, the function should work exactly like ft_atoi.
; • If there’s an invalid argument, the function should return 0. Examples of invalid
; arguments :
; 	◦ base is empty or size of 1;
; 	◦ base contains the same character twice ;
; 	◦ base contains + or - or whitespaces;


section .data
prob_char 

section .bss

section .text

;Register usage:
;rdi - str ,string input
;rsi - base ,string base number
;r12 - tmp_str ,string input
;r13 - tmp_base ,string base number
;r14 - strlen(str)
;rcx - ptr ,tempolary ptr
;rbx - cmp ,tempolary compare 
;$rax - diff(ruturn value of differential of string)

global ft_atoi_base

extern	ft_strlen

ft_atoi_base:
	mov		r12, rdi			;preserve input
	mov		r13, rsi			;preserve input

chk_base_len:
	mov		rdi, r13			;if (*base < 2)
	call	ft_strlen			;	return 0
	cmp		rax, 2				;
	jl		ret_err				;else
	mov		r14, rax			;	base_len

	; chk base duplication
chk_base_dup:
	mov		byte bl, [r13]
	cmp		byte bl, 0
	je		chk_prohibit_char
	mov		rcx, r13
inc_ptr:
	inc		rcx
	cmp		byte [rcx], bl
	je		ret_err

	cmp		byte [rcx], 0
	jne		inc_ptr

	inc		r13
	jmp		chk_base_dup
	
chk_prohibit_char:
	

ret_err:
	mov		rax, 0
	
ret_output:
	ret


