;void	ft_list_push_front(t_list **begin_list, void *data)

section .text

;Register usage:
;rdi - **begin_list
;rsi - *data

global ft_list_push_front

extern	malloc

ft_list_push_front:

