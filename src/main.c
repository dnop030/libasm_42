#include "header.h"
#include <unistd.h>

int	main(void)
{
	char msg[50] = "test message\n";
	ft_write(1, msg, 13);
	// write(1, msg, 13);
	return 0;
}
