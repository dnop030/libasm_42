#include "header_bonus.h"

void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(void *, void *),
							void (*free_fct)(void *))
{
	// volatile t_list	*prev_node, *pres_node, *del_node;
	t_list	*prev_node, *pres_node, *del_node;

	// previous node will be assigned only
	// when found 1st node which need NOT to delete
	prev_node = NULL;
	pres_node = *begin_list;

	while (pres_node != NULL)
	{
		if ((*cmp)(pres_node->data, data_ref) == 0)
		{
			// assign 1st node back to main function
			if (prev_node == NULL)
				*begin_list = pres_node->next;

			// assign deleted node
			del_node = pres_node;

			// move pres & prev node ptr
			// if (prev_node != NULL && prev_node != *begin_list)
			if (prev_node != NULL && prev_node->next != del_node)
				prev_node = prev_node->next;
			pres_node = pres_node->next;

			// connect linklist
			if (prev_node != NULL)
			{
				if (pres_node == NULL)
					prev_node->next = NULL;
				else
					prev_node->next = pres_node;
			}

			// delete node
			(*free_fct)(del_node->data);
			free(del_node);

		}
		else
		{
			if (prev_node == NULL)
				prev_node = *begin_list;
			else
				prev_node = pres_node;
			pres_node = pres_node->next;
		}
	}
}
