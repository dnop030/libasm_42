#include "header_bonus.h"

int bonus_test_count = 0;
int bonus_failed = 0;

void test_atoi_base_10(char *str)
{
	bonus_test_count++;
	int ret = ft_atoi_base(str, "0123456789");
	int atoi_base = atoi(str);
	if (ret == atoi_base)
		printf("ft_atoi_base 10: \x1b[32mOK\n\n");
	else
	{
		printf("ft_atoi_base 10: \x1b[31mKO\n\n");
		bonus_failed++;
	}
	printf("str: %s\n", str);
	printf("atoi_base: %d\n", atoi_base);
	printf("ft_atoi_base: %d\033[0m\n\n", ret);
}

void test_atoi_base(char *str, char *base, int expected)
{
	bonus_test_count++;
	int ret = ft_atoi_base(str, base);
	if (ret == expected)
		printf("ft_atoi_base: \x1b[32mOK\n\n");
	else
	{
		printf("ft_atoi_base: \x1b[31mKO\n\n");
		bonus_failed++;
	}
	printf("str: %s\n", str);
	printf("base: %s\n", base);
	printf("expected: %d\n", expected);
	printf("ft_atoi_base: %d\033[0m\n\n", ret);
}

void test_list_push_front(t_list **list, char *str)
{
	bonus_test_count++;
	printf("before: %p\n",*list);
	ft_list_push_front(list, str);
	printf("after: %p\n\n",*list);
	if (!list)
	{
		printf("ft_list_push_front: \x1b[31mKO\n\n");
		printf("failed to malloc\n\n");
		bonus_failed++;
		return ;
	}
	if (*list && !strcmp((*list)->data, str))
		printf("ft_list_push_front: \x1b[32mOK\n\n");
	else
	{
		printf("ft_list_push_front: \x1b[31mKO\n\n");
		bonus_failed++;
	}
	printf("list->data: %s\n", (char *)(*list)->data);
	printf("list->next: %p\033[0m\n\n", (*list)->next);
}

void test_list_size(t_list *list)
{
	bonus_test_count++;
	int ret = ft_list_size(list);
	int size = 0;
	while (list)
	{
		size++;
		list = list->next;
	}
	if (ret == size)
		printf("ft_list_size: \x1b[32mOK\n\n");
	else
	{
		printf("ft_list_size: \x1b[31mKO\n\n");
		bonus_failed++;
	}
	printf("list size: %d\n", size);
	printf("ft_list_size: %d\033[0m\n\n", ret);
}

int	main(void)
{
	// test atoi_base
	test_atoi_base_10("42");
	test_atoi_base_10("0");
	test_atoi_base_10("1");
	test_atoi_base_10("1215415478");
	test_atoi_base("42", "0123456789", 42);
	test_atoi_base("0", "0123456789", 0);
	test_atoi_base("1", "0123456789", 1);
	test_atoi_base("1215415478", "0123456789", 1215415478);
	test_atoi_base("-0", "0123456789", 0);
	test_atoi_base("-1", "0123456789", -1);
	test_atoi_base("-42", "0123456789", -42);
	test_atoi_base("a", "0123456789abcdef", 10);
	test_atoi_base("123", "+", 0);
	test_atoi_base("123", " 0123456789", 0);
	test_atoi_base("123", "0123456789+", 0);
	test_atoi_base("123", "0123456789\n", 0);

	// test list_push_front
	t_list *list = NULL;
	test_list_push_front(&list, "1");
	test_list_push_front(&list, "0");
	test_list_push_front(&list, "2");
	test_list_push_front(&list, "3");
	test_list_push_front(&list, "4");

	// test list_size
	test_list_size(list);
	test_list_size(NULL);

	return 0;
}
