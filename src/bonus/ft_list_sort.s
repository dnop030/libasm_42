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
;r09 - *tmp_n
;r10 - tmp(for move data from mem2mem)

ft_list_sort:

;prove_concept:
;	mov		qword rcx, [rdi]				;*begin_list
;	mov		qword r9, [rcx + t_list.data]	;(*begin_list)
;	mov		qword r10, [r9]

;;rbx - 1 st node
;;rcx - 2 nd node
;;r9 - 3 rd node
;;3 1 2
;;test swap node 1 and node2
;	mov		rbx, [rdi]
;	mov		rcx, [rbx + t_list.next]
;	mov		r9, [rcx + t_list.next]
;	mov		qword [rbx + t_list.next], 0
;	mov		qword [rcx + t_list.next], 0
;	mov		qword [r9 + t_list.next], 0
;	
;	;re-order
;	mov		qword [r9 + t_list.next], rbx
;	mov		qword [rbx + t_list.next], rcx
;
;	;put bact to begin_list
;	mov		[rdi], r9


;preserve_ip:
;	push	rdi
;
;chk_input_not_null:
;	cmp		qword rdi, 0
;	je		return
;	cmp		qword [rdi], 0
;	je		return
;	cmp		qword rsi, 0
;	je		return
;
;assign_ptr:
;	mov		qword rbx, rdi
;	mov		qword r12, rsi
;
;assign_var:
;	mov		qword r13, [rbx]				;head_new = *begin_list
;	mov		qword r10, [rbx + t_list.next]	;*begin_list = (*begin_list)->next	;+++++++
;	mov		qword [rbx], r10				;
;	mov		qword [r13 + t_list.next], 0	;head_new->next = NULL
;
;loop_old_lst:
;	cmp		qword [rbx], 0
;	je		set_new_lst_back
;
;set_node_cmp
;	mov		qword r14, 0
;	mov		qword r15, r13
;
;loop_srch_pos_new_lst:
;	cmp		qword r15, 0
;	je		mv_node_2_new_lst
;
;cmp_data:
;	mov		rdi, [rbx + t_list.data]
;	mov		rsi, [r15 + t_list.data]
;	call	r12
;	cmp		qword rax, 0
;	jl		mv_node_2_new_lst
;	mov		qword r14, r15
;	mov		qword r15, [r15 + t_list.next]
;	jmp		loop_srch_pos_new_lst
;
;mv_node_2_new_lst:
;	mov		qword r9, [rbx]
;	mov		qword r10, [rbx + t_list.next]	;+++++++++++++++++++++++++
;	mov		qword [rbx], r10
;	mov		qword [r9 + t_list.next], 0
;
;add_lst_node:
;	cmp		qword r15, 0
;	jne		add_first_node
;	mov		qword [r14 + t_list.next], r9 ;++++++++++++
;	jmp		loop_srch_pos_new_lst
;
;add_first_node:
;	cmp		qword r14, 0
;	jne		add_mid_list
;	mov		qword [r9 + t_list.next], r13
;	mov		qword r13, r9
;	jmp		loop_srch_pos_new_lst
;
;add_mid_list:
;	mov		qword [r14 + t_list.next], r9
;	mov		qword [r9 + t_list.next], r15
;	jmp		loop_srch_pos_new_lst
;
;set_new_lst_back:
;	pop		r8
;	mov		qword [r8], r13
	
return:
	xor		rax,rax ; ********************
	ret