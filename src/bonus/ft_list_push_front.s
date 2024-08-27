;void	ft_list_push_front(t_list **begin_list, void *data)
;t_list	*ft_create_elem(void *data)

section .bss

struc t_list
	data: resq	1
	next: resq	1
endstruc

section .text

;Register usage:
;r12 - **begin_list
;r13 - *data

global ft_list_push_front

extern	malloc
extern	sizeof
extern	__errno_location

ft_list_push_front:
	mov		r12, rdi
	mov		r13, rsi
	mov		rdi, r13
	call	ft_create_elem

;Register usage:
;r12 - sizeof(t_list)
ft_create_elem:
	xor		rax, rax				; reset output
	mov		rdi, t_list
    call    sizeof


