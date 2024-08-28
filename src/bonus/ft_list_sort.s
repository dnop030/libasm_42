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

ft_list_sort:
    cmp     qword rdi, 0
    je      return
    cmp     qword [rdi], 0
    je      return
    cmp     qword rsi, 0
    je      return

assign_ptr:
    mov     rbx, rdi
    mov     r12, rsi

assign_var:
    mov     r13, [rbx]
    
    
    xor     rax,rax
return:
    ret