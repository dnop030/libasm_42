;void	ft_list_push_front(t_list **begin_list, void *data)
;t_list	*ft_create_elem(void *data)

section .bss

struc t_list
	.data: resq	1
	.next: resq	1
endstruc

section .data



section .text

;t_list_size equ $-t_list

;Register usage:
;r12 - **begin_list
;r13 - *data
;r14 - *begin_list

global ft_list_push_front

extern	malloc
extern	__errno_location

ft_list_push_front:
	mov		r12, rdi
	mov		r13, rsi
	mov		rdi, r13
	call	ft_create_elem
	cmp		rax, 0
	je		return

	mov		r14, [r12]
	mov		[rax + t_list.next], r14
	mov		[r12], rax

return:
	ret


;Register usage:
;r15 - *data
;rbx - tmp for err status of malloc
ft_create_elem:
	xor		rax, rax				; reset output
	mov		r15, rdi				; preserve input

;	mov		rdi, t_list_size
	mov		rdi, 16
	call	malloc wrt ..plt
	cmp		rax, 0
	je		set_err

	mov		[rax + t_list.data], r15
	mov		qword [rax + t_list.next], 0 ; should be qword
	ret

set_err:
	push	rax
	call	__errno_location wrt ..plt

	pop		rbx
	neg		rbx

	mov		byte [rax], bl
	xor		rax, rax
	ret

