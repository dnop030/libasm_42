#include "header_bonus.h"

int		ft_list_size(t_list *begin_list)
{
	int	cnt = 0;

	while(begin_list != NULL)
	{
		cnt++;
		begin_list = begin_list->next;
	}

	return cnt;
}
