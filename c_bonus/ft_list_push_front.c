#include "header_bonus.h"

t_list	*ft_create_elem(void *data)
{
	t_list	*tmp;

	tmp = malloc(sizeof(t_list));
	if (tmp != NULL)
	{
		tmp->data = data;
		tmp->next = NULL;
	}

	return tmp;
}

void	ft_list_push_front(t_list **begin_list, void *data)
{
	t_list	*node;
	node = ft_create_elem(data);
	if (node != NULL)
	{
		node->next = *begin_list;
		*begin_list = node;
	}
}
