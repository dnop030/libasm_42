;void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(),
;				void (*free_fct)(void *));

section .bss

struc t_list
	.data: resq	1
	.next: resq	1
endstruc

section .text

global ft_list_remove_if

extern	free

;Register usage:
;rbx - *data_ref
;r12 - (*cmp)
;r13 - (*free)
;r14 - *prev_n
;r15 - *pres_n

;r10 - *del_node
;r11 - tmp(for move data from mem2mem)

ft_list_remove_if:
	cmp		qword rdi, 0
	je		return
	cmp		qword [rdi], 0
	je		return
	cmp		qword rsi, 0
	je		return
	cmp		qword rdx, 0
	je		return
	cmp		qword rcx, 0
	je		return

preserve_ptr:
	push	rdi

assign_var_reg:
	mov		rbx, rsi
	mov		r12, rdx
	mov		r13, rcx

assign_ptr:
	mov		r14, qword 0
	pop		r15
	push	r15
	mov		r15, qword [r15]

loop:
	cmp		qword r15, 0
	je		return

cmp_node:
	xor		rax, rax					; reset rax
	pop		r11
	push	r11
	mov		rdi, [r11]
	mov		rdi, [rdi + t_list.data]
	mov		rsi, rbx
	call	r12
	cmp		qword rax, 0
	jne		find_del_node

assign_first_node_back:
	cmp		qword r15, 0
	jne		assign_del_node
	pop		r11
	push	r11
	mov		[r11], [r15 + t_list.next]

assign_del_node:
	mov		r10, r15

mv_pres_n_prev:
	cmp		qword r14, 0
	je		mv_pres
	cmp		[r14 + t_list.next], r10
	je		mv_pres
	mov		r14, [r14 + t_list.next]

mv_pres:
	mov		r15, [r15 + t_list.next]

connect_linklst:
	cmp		qword r14, 0
	je		del_node
	cmp		qword r15, 0
	jne		els_mv_prev
	mov		qword [r14 + t_list.next], 0
	jmp		del_node

els_mv_prev:
	mov		qword [r14 + t_list.next], r15

del_node:
	mov		rdi, [r10 + t_list.data]	;*********
	call	r13
	mov		rdi, r10
	call	free						;******

find_del_node:
	cmp		qword r14, 0
	jne		els_find_del_node
	pop		r11
	push	r11
	mov		r14, qword [r11]
	jmp		mv_pres_node

els_find_del_node:
	mov		r14, r15

mv_pres_node:
	mov		r15, [r15 + t_list.next]

return:
	xor		rax, rax
	ret
