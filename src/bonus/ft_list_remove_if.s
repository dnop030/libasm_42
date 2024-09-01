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

;r10 - *del_node, tmp
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
	mov		r14, qword 0						; prev_n = NULL
	pop		r15									;
	push	r15									;
	mov		r15, qword [r15]					; pres_n = *begin_list

loop:
	cmp		qword r15, 0						; while (pres_n != NULL)
	je		return								; ^

cmp_node:
	mov		rdi, [r15 + t_list.data]			; if ((*cmp)(pres_node->data, data_ref) == 0)
	mov		rsi, rbx							;
	call	r12									;
	cmp		qword rax, 0
	jne		find_del_node

assign_first_node_back:
	cmp		qword r14, 0						; if (prev_node == NULL)
	jne		assign_del_node						;
	pop		r11									;
	push	r11									;
	mov		qword r10, [r15 + t_list.next]		;
	mov		qword [r11], r10					; *begin_list = pres_node->next;

assign_del_node:
	mov		r10, r15							; del_node = pres_node;

mv_pres_n_prev:
	cmp		qword r14, 0						; if (prev_node != NULL
	je		mv_pres								;
	cmp		[r14 + t_list.next], r10			; prev_node->next != del_node )
	je		mv_pres								;
	mov		r14, [r14 + t_list.next]			; prev_node = prev_node->next;

mv_pres:
	mov		r15, [r15 + t_list.next]			; pres_node = pres_node->next;

connect_linklst:
	cmp		qword r14, 0						; if (prev_node != NULL)
	je		del_node
	cmp		qword r15, 0						; if (pres_node == NULL)
	jne		els_mv_prev
	mov		qword [r14 + t_list.next], 0		; prev_node->next = NULL;
	jmp		del_node

els_mv_prev:
	mov		qword [r14 + t_list.next], r15		; prev_node->next = pres_node;

del_node:
	mov		rdi, [r10 + t_list.data]			; (*free_fct)(del_node->data);
	call	r13									; ^
	mov		rdi, r10							; free(del_node);
	call	free wrt ..plt						; ^
	jmp		loop

find_del_node:
	cmp		qword r14, 0						; if (prev_node == NULL)
	jne		els_find_del_node
	pop		r11
	push	r11
	mov		r14, qword [r11]					; prev_node = *begin_list;
	jmp		mv_pres_node

els_find_del_node:
	mov		r14, r15							; prev_node = pres_node;

mv_pres_node:
	mov		r15, [r15 + t_list.next]			; pres_node = pres_node->next;
	jmp		loop

return:
	pop		rax
	xor		rax, rax
	ret
