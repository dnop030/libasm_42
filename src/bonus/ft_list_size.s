;int		ft_list_size(t_list *begin_list)

section .bss

struc t_list
	.data: resq	1
	.next: resq	1
endstruc


section .text

global ft_list_size

;Register usage:
;rax - cnt => output
;rdi - *begin_list

ft_list_size:

	xor		rax, rax
loop:
	cmp		qword rdi, 0
	je		return
	inc		rax
	mov		rdi, [rdi + t_list.next]
	jmp		loop

return:
	ret
