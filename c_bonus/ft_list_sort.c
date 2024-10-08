#include "header_bonus.h"

// insertion sort
void	ft_list_sort(t_list **begin_list, int (*cmp)(void *, void *))
{
	t_list	*head_new, *prev_n, *pres_n, *tmp_n;

	if (begin_list == NULL || (*begin_list) == NULL || (*cmp) == NULL)
		return;

	head_new = *begin_list;
	*begin_list = (*begin_list)->next;
	head_new->next = NULL;

	// sorting from old linklist to new linklist
	while (*begin_list != NULL)
	{
		prev_n = NULL;
		pres_n = head_new;

		// finding position of 1st node in old linklist in new linklist
		while (pres_n != NULL)
		{
			if ((*cmp)((*begin_list)->data, pres_n->data) < 0)
			{
				break;
			}
			else
			{
				prev_n = pres_n;
				pres_n = pres_n->next;
			}
		}

		// move node from old linklist to new linklist
		tmp_n = *begin_list;
		*begin_list = (*begin_list)->next;
		tmp_n->next = NULL;

		// add to last node
		if (pres_n == NULL)
			prev_n->next = tmp_n;
		else
		{
			// add to 1st node
			if (prev_n == NULL)
			{
				tmp_n->next = head_new;
				head_new = tmp_n;
			}
			// add in the middle of linklist
			else
			{
				prev_n->next = tmp_n;
				tmp_n->next = pres_n;
			}
		}
	}
	*begin_list = head_new;
}
