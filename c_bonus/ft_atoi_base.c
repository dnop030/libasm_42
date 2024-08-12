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

int	chk_base_dup(char *base);
int	chk_prohibit_char(char *base);
int	conv(char *str, char *base);

int		ft_atoi_base(char *str, char *base)
{
	int	base_n = strlen(base);
	int	base_dup = chk_base_dup(base);
	int	prohibit_char = chk_prohibit_char(base);
	int	res = 0;

	if ((base_n >= 1) && (base_dup == 0) && (prohibit_char == 0)) {
		res = conv(str, base);
	}
	return res;
}

int	conv(char *str, char *base)
{
	int		res = 0;
	int		mul = strlen(base);
	int		tmp;
	int		sign = 1;
	char	*tmp_base;

	// move ptr until it found 1st number
	while (*str < 48)
	{
		if (*str == 45)
			sign = sign * (-1);
		str++;
	}
	while (*str != 0)
	{
		tmp_base = base;
		// searching for string in base
		// prevent str not in base
		while((*tmp_base != *str) && (*tmp_base != 0))
			tmp_base++;

		// str not in base
		if (*tmp_base == 0)
			return 0;
		else
		{
			tmp = (tmp_base - base);
		}

		res = (res * mul) + tmp;
		str++;
	}
	return (res * sign);
}

int	chk_base_dup(char *base)
{
	char	*ptr1, *ptr2;

	ptr1 = base;
	while (*ptr1 > 0)
	{
		ptr2 = ptr1 + 1;
		while (*ptr2 > 0)
		{
			if (*ptr1 == *ptr2)
				return 1;
			ptr2++;
		}
		ptr1++;
	}
	return 0;
}

int	chk_prohibit_char(char *base)
{
	char	prohi_chr[] = "+- \t\n\v\f\r";
	char	*ptr = prohi_chr;
	char	*ptr_base = base;

	while (*ptr_base != 0)
	{
		ptr = prohi_chr;
		while(*ptr != 0)
		{
			if (*ptr_base == *ptr)
				return 1;
			ptr++;
		}
		ptr_base++;
	}
	return 0;
}
