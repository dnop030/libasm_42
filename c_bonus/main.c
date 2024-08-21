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

void test_list_sort(t_list **list)
{
	t_list *tmp = *list;
	bonus_test_count++;
	while (tmp)
	{
		// check if data is sorted
		printf("list->data: %s\n", (char *)(tmp)->data);
		tmp = tmp->next;
	}
	tmp = *list;
	printf("\n\nsorting ...\n\n");
	ft_list_sort(list, strcmp);
	while (tmp)
	{
		// check if data is sorted
		printf("list->data: %s\n", (char *)(tmp)->data);
		tmp = tmp->next;
	}
	while ((*list)->next)
	{
		// check if data is sorted
		if (strcmp((*list)->data, (*list)->next->data) > 0)
		{
			printf("ft_list_sort: \x1b[31mKO\x1b[0m\n\n");
			bonus_failed++;
			return ;
		}
		list = &(*list)->next;
	}
	printf("ft_list_sort: \x1b[32mOK\x1b[0m\n\n");
}

void test_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(void *,void *), void (*free_fct)(void *))
{
	bonus_test_count++;
	ft_list_remove_if(begin_list, data_ref, cmp, free_fct);
	while (*begin_list)
	{
		printf("list->data: %s\n", (char *)(*begin_list)->data);
		if ((*cmp)((*begin_list)->data, data_ref) == 0)
		{
			printf("ft_list_remove_if: \x1b[31mKO\x1b[0m\n\n");
			bonus_failed++;
			return ;
		}
		begin_list = &(*begin_list)->next;
	}
	printf("ft_list_remove_if: \x1b[32mOK\x1b[0m\n\n");
}

int strcmp_wrapper(void *a, void *b)
{
	return strcmp((char *)a, (char *)b);
}

int main(void)
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

	test_list_sort(&list);

	// should not crash
	t_list *null_list = NULL;

	ft_list_sort(&list, NULL);
	ft_list_sort(&null_list, NULL);
	ft_list_sort(NULL, NULL);

	printf("NULL list test: \x1b[32mOK\n\n");

	// test list_remove_if
	t_list *list_remove_if = NULL;
	ft_list_push_front(&list_remove_if, strdup("1"));
	ft_list_push_front(&list_remove_if, strdup("2"));
	ft_list_push_front(&list_remove_if, strdup("1"));
	ft_list_push_front(&list_remove_if, strdup("3"));
	ft_list_push_front(&list_remove_if, strdup("4"));
	ft_list_push_front(&list_remove_if, strdup("5"));

	test_list_remove_if(&list_remove_if, "1", strcmp_wrapper, free);

	// *test_count += bonus_test_count;
	// *test_failed += bonus_failed;

	return 0;
}
