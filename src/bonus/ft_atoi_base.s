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

section .bss

section .text

;Register usage:
;rdi - str ,string input
;rsi - base ,string base number
;r12 - tmp_str ,string input
;r13 - tmp_base ,string base number
;rcx - ptr ,tempolary ptr
;rbx - sign mul
;$rax - res, result of convert(ruturn value of differential of string)

global ft_atoi_base

extern	ft_strlen

ft_atoi_base:
	mov		r12, rdi			; preserve input
	mov		r13, rsi			; preserve input

	mov		rdi, r13
	call	ft_strlen			; if (strlen(base) < 2)
	cmp		rax, 2				;	return 0;
	jl		ret_err

	mov		rdi, r13
	call	chk_base_dup		; if (chk_base_dup != 0)
	cmp		rax, 0				;	return 0;
	jne		ret_err

	mov		rdi, r13
	call	chk_prohibit_char	; if (chk_prohibit_char != 0)
	cmp		rax, 0				;	return 0;
	jne		ret_err

	mov		rdi, r12
	mov		rsi, r13
	call	conv_val
	jmp		ret_output

ret_err:
	mov		rax, 0

ret_output:
	ret


;Register Usage
;rdi - ptr1 = base
;rcx - ptr2 = base + 1
;bl - *ptr1
;rax - output
chk_base_dup:
	mov		rax, 0				; set output = 0
	jmp		loop_ptr1

inc_ptr1:
	inc		rdi
loop_ptr1:
	cmp		byte [rdi], 0		; while (*base != 0)
	je		ret_base_dup		; {
	mov		byte bl, [rdi]		;
	mov		rcx, rdi			;
loop_ptr2:
	inc		rcx					;	ptr2 = ptr1 + 1
	cmp		byte [rcx], 0		;	while (*ptr2 != 0) {
	je		inc_ptr1			;
	cmp		byte bl, [rcx]		;		if (*ptr2 == *ptr1)
	jne		loop_ptr2			;

set_err_output:
	mov		rax, 1				; 			return 1}}

ret_base_dup:
	ret


;Register Usage
;rdi - ptr1, base str
;bl - tmp_cmp
chk_prohibit_char:
	mov		rax, 0				; set output = 0

cmp_prohibit:
	mov		byte bl, [rdi]
	cmp		byte bl, 0
	je		ret_prohibit
	cmp		byte bl, '+'
	je		set_err_out
	cmp		byte bl, '-'
	je		set_err_out
	cmp		byte bl, ' '
	je		set_err_out
	cmp		byte bl, 0x09 ; '\t'
	je		set_err_out
	cmp		byte bl, 0x0a ; '\n'
	je		set_err_out
	cmp		byte bl, 0x0b ; '\v'
	je		set_err_out
	cmp		byte bl, 0x0c ; '\f'
	je		set_err_out
	cmp		byte bl, 0x0d ; '\r'
	je		set_err_out
	inc		rdi
	jmp		cmp_prohibit

set_err_out:
	mov		rax, 1

ret_prohibit:
	ret

;Register Usage
;rdi - *str
;rsi - *base
;r13 - *tmp_base
;r14 - *tmp_str
;r15 - tmp val
;rcx - mul <= base length
;r0 - sign (-1)
;rax - output
conv_val:
	mov		r13, rsi		; reserve base str ptr
	mov		r14, rdi		; reserve str str ptr

get_base_len:
	mov		rdi, rsi
	call	ft_strlen
	mov		rcx, rax

	mov		rdi, r14		; init str
start_cal:
	mov		r9, 1			; init sign val
	mov		rax, 0			; init output val
chk_neg:
	mov		byte bl, [rdi]
	cmp		byte bl, 0
	je		loop_str
	cmp		byte bl, '0'
	jge		loop_str
	cmp		byte bl, '-'
	jne		inc_neg
	neg		r9
inc_neg:
	inc		rdi
	jmp		chk_neg

loop_str:
	mov		byte bl, [rdi]	; while(*str != 0)
	cmp		byte bl, 0		;
	je		ret_conv_val

	mov		rsi, r13		; 	tmp_base = base
loop_base:
	cmp		byte [rsi], 0
	je		ret_conv_val
	cmp		byte [rsi], bl
	je		cal_output
	inc		rsi
	jmp		loop_base
cal_output:
	mov		r15, rsi
	sub		r15, r13
	mul		rcx
	add		rax, r15
	inc		rdi
	jmp		loop_str

ret_conv_val:
	mul		r9
	ret
