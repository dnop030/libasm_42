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
;r14 - strlen(str) ++++++++++++++++++++++++++++
;rcx - ptr ,tempolary ptr
;rbx - sign mul
;$rax - res, result of convert(ruturn value of differential of string)

global ft_atoi_base

extern	ft_strlen

ft_atoi_base:
	mov		r12, rdi			; preserve input
	mov		r13, rsi			; preserve input

	mov		rdi, r13
	call	ft_strlen
	cmp		rax, 2
	jl		ret_err

	mov		rdi, r13
	call	chk_base_dup
	cmp		rax, 0
	jne		ret_err

	mov		rdi, r13
	call	chk_prohibit_char
	cmp		rax, 0
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
;rdi - ptr1
;rcx - ptr2
;bl - *ptr1
;rax - output
chk_base_dup:
	mov		rax, 0			; set output = 0
	jmp		loop_ptr1

inc_ptr1:
	inc		rdi
loop_ptr1:
	cmp		byte [rdi], 0
	je		ret_base_dup
	mov		byte bl, [rdi]
	mov		rcx, rdi
loop_ptr2:
	inc		rcx
	cmp		byte [rcx], 0
	je		inc_ptr1
	cmp		byte bl, [rcx]
	jne		loop_ptr2

set_err_output:
	mov		rax, 1

ret_base_dup:
	ret


;Register Usage
;rdi - ptr1, base str
;bl - tmp_cmp
chk_prohibit_char:
	mov		rax, 0			; set output = 0

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
	cmp		byte bl, '\t'
	je		set_err_out
	cmp		byte bl, '\n'
	je		set_err_out
	cmp		byte bl, '\v'
	je		set_err_out
	cmp		byte bl, 'f'
	je		set_err_out
	cmp		byte bl, 'r'
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
	mov		rax, 0			; risk ++++++++++++++++++
	je		ret_conv_val	; risk ++++++++++++++++++
	cmp		byte [rsi], bl
	je		cal_output
	inc		r13
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








;ft_atoi_base:
;	mov		r12, rdi			;preserve input
;	mov		r13, rsi			;preserve input
;
;chk_base_len:
;	mov		rdi, r13			;if (*base < 2)
;	call	ft_strlen			;	return 0
;	cmp		rax, 2				;
;	jl		ret_err				;else
;	mov		r14, rax			;	base_len
;
;	; chk base duplication
;chk_base_dup:
;	mov		byte bl, [r13]
;	cmp		byte bl, 0
;	je		chk_prohibit_char
;	mov		rcx, r13
;inc_ptr_dup:
;	cmp		byte [rcx], bl
;	inc		rcx
;	je		ret_err
;
;	cmp		byte [rcx], 0
;	jne		inc_ptr_dup
;
;	inc		r13
;	jmp		chk_base_dup
;
;	; chk prohibit charactor
;	mov		r13, rsi			; reload base ptr
;chk_prohibit_char:
;	cmp		byte [r13], '-'
;	je		ret_err
;	cmp		byte [r13], '+'
;	je		ret_err
;	cmp		byte [r13], ' '
;	je		ret_err
;	cmp		byte [r13], '\t'
;	je		ret_err
;	cmp		byte [r13], '\n'
;	je		ret_err
;	cmp		byte [r13], '\v'
;	je		ret_err
;	cmp		byte [r13], '\f'
;	je		ret_err
;	cmp		byte [r13], '\r'
;	je		ret_err
;inc_ptr_prohibit:
;	inc		r13
;	cmp		byte [r13], 0
;	jne		chk_prohibit_char
;
;	; convert value
;	xor		rax, rax			; res = 0
;	mov		rdi, r12			; reset addr of rdi
;	mov		rbx, 1				; assign sign to 1
;cal_neg:
;	cmp		byte [rdi], '0'
;	jge		cal_val
;	cmp		byte [rdi], '-'
;	jne		inc_ptr_sign
;	neg		rbx
;inc_ptr_sign:
;	inc		rdi
;	jmp		cal_neg
;
;	; 1 char of number is pointed by rdi
;cal_val:
;	mov		byte al, [rdi]
;	mov		r13, rsi			; reload base ptr
;find_char_in_base:
;	cmp		al, [r13]
;	je		get_val
;	cmp		byte [r13], 0
;	je		ret_err
;	inc		r13
;	jmp		find_char_in_base
;
;get_val:
;;	sub		r13, rsi
;	mov		rax, r13
;	jmp		ret_output
;
;ret_err:
;	mov		rax, 0
;
;ret_output:
;	ret
