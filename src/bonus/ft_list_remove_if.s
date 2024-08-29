;void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(),
;				void (*free_fct)(void *));


section .bss

struc t_list
	.data: resq	1
	.next: resq	1
endstruc

section .text

global ft_list_remove_if

;Register usage:
;rbx - **begin_list
;r12 - (*cmp)
;r13 - *head_new
;r14 - *prev_n
;r15 - *pres_n
;r9 - *tmp_n
;r10 - tmp(for move data from mem2mem)

ft_list_remove_if:
