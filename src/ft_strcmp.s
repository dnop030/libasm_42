;ft_strcmp.s
;int ft_strcmp(const char *s1, const char *s2)


section .text

;Register usage:
;$rdi - ps1	(pointer to input string1)
;$rsi - ps2	(pointer to input string2)
;$rcx - cnt	(counter to increment pointer of both string)
;$rdx - tmp reg to store *ps2 value in order to find diff
;$rax - diff(ruturn value of differential of string)

global ft_strcmp
ft_strcmp:
	mov	rcx, 0						; reset cnt
	jmp	ifstr1Null

inccnt:
	inc rcx							; inc cnt
ifstr1Null:
	cmp	byte [rdi + rcx], 0				; if (*(ps1 + cnt) != NULL)
	je	caloutput

	; this line is not work due to cannot compare memory with memory
	;cmp byte [rdi + rcx], [rsi + rcx]	; if *(ps1+cnt) == *(ps2+cnt)

	mov	al, [rdi + rcx]
	cmp byte al, [rsi + rcx]		; if (*(ps1 + cnt) == *(ps2 + cnt))
	je	inccnt

caloutput:
	;; 1st version
	;movzx	eax, byte [rdi + rcx]
	;sub eax, byte [rsi + rcx]

	; 2nd walk around => work!
	movzx	eax, byte [rdi + rcx]
	movzx	edx, byte [rsi + rcx]
	sub	eax, edx

	ret
