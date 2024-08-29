;void	ft_list_sort(t_list **begin_list, int (*cmp)(void *, void *))

section .bss

struc t_list
	.data: resq	1
	.next: resq	1
endstruc

section .text

global ft_list_sort

;Register usage:
;rbx - **begin_list
;r12 - (*cmp)
;r13 - *head_new
;r14 - *prev_n
;r15 - *pres_n
;r9 - *tmp_n
;r10 - tmp(for move data from mem2mem)

ft_list_sort:

preserve_ip:
	push	rdi

chk_input_not_null:
	cmp		qword rdi, 0
	je		return
	cmp		qword [rdi], 0
	je		return
	cmp		qword rsi, 0
	je		return

assign_ptr:
	mov		qword rbx, rdi
	mov		qword r12, rsi

assign_var:
	mov		qword r13, [rbx]				;head_new = *begin_list
	mov		qword r10, [r13 + t_list.next]	;*begin_list = (*begin_list)->next
	mov		qword [rbx], r10				;^
	mov		qword [r13 + t_list.next], 0	;head_new->next = NULL

loop_old_lst:
	cmp		qword [rbx], 0					; *begin_list != NULL
	je		set_new_lst_back

set_node_cmp:
	mov		qword r14, 0					; prev_n = NULL
	mov		qword r15, r13					; pres_n = head_new;

loop_srch_pos_new_lst:
	cmp		qword r15, 0					; pres_n != NULL
	je		mv_node_2_new_lst

cmp_data:
	mov		r10, [rbx]						; (*begin_list)->data
	mov		rdi, [r10 + t_list.data]		; ^
	mov		rsi, [r15 + t_list.data]		; pres_n->data
	call	r12								; if ((*cmp)((*begin_list)->data, pres_n->data) < 0)
	cmp		dword eax, 0					; ^
	jl		mv_node_2_new_lst				; ^
	mov		qword r14, r15					; prev_n = pres_n
	mov		qword r15, [r15 + t_list.next]	; pres_n = pres_n->next
	jmp		loop_srch_pos_new_lst

mv_node_2_new_lst:
	mov		qword r9, [rbx]					; tmp_n = *begin_list
	mov		qword r10, [r9 + t_list.next]	; *begin_list = (*begin_list)->next
	mov		qword [rbx], r10				; ^
	mov		qword [r9 + t_list.next], 0		; tmp_n = NULL

add_lst_node:
	cmp		qword r15, 0
	jne		add_first_node
	mov		qword [r14 + t_list.next], r9
	jmp		loop_old_lst

add_first_node:
	cmp		qword r14, 0
	jne		add_mid_list
	mov		qword [r9 + t_list.next], r13
	mov		qword r13, r9
	jmp		loop_old_lst

add_mid_list:
	mov		qword [r14 + t_list.next], r9
	mov		qword [r9 + t_list.next], r15
	jmp		loop_old_lst

set_new_lst_back:
	pop		r8
	mov		qword [r8], r13

return:
	xor		rax,rax ;
	ret
