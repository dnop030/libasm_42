#include "header.h"
#include <stddef.h>

int	main(void)
{
	size_t	ret;
	char msg[50] = "test message\n";
	ret = ft_write(1, msg, 13);
	printf("ft_wr ret:%zu\n", ret);
	// ret = write(1, msg, 13);
	// printf("wr ret:%zu\n", ret);
	return 0;
}
