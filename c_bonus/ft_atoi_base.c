#include "header_bonus.h"

// • Write a function that converts the initial portion of the string pointed by str to int
// representation.
// • str is in a speciﬁc base given as a second parameter.
// • excepted the base rule, the function should work exactly like ft_atoi.
// • If there’s an invalid argument, the function should return 0. Examples of invalid
// arguments :
// 	◦ base is empty or size of 1;
// 	◦ base contains the same character twice ;
// 	◦ base contains + or - or whitespaces;

int		ft_atoi_base(char *str, char *base)
{
	int	base_n = strlen(base);
	int	base_dup = chk_base_dup(base);

	if (base_n >= 1) {
		printf("%s\n", str);
		printf("len base:%lu\n", strlen(base));
		printf("%c\n", base[strlen(base)-1]);
	}

	return 1;
}

int	chk_base_dup(char *base)
{

}
