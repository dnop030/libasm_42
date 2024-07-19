# libasm

## Its libft but in asm can be use just like libft

# General Instructions
## Dos
- You must write 64 bits ASM. Beware of the "calling convention".
- You must compile your assembly code with nasm.
- You must use the Intel syntax, not the AT&T.

## Don'ts
- You can’t do inline ASM, you must do ’.s’ files. (no asm in c)
- It is forbidden to use the compilation flag: -no-pie.

## Makefile rules
- contain at least $(NAME), all, clean, fclean, re.
- recompile/relink only necessary files.
- Bonuses must be in a different file _bonus.{c/h}.

# Mandatory part

- library must be call "libasm.a"

- submit a main that will test your functions and that will compile with library to show that it's functional

- You must rewite the following functions in asm:
    - ft_strlen (man 3 strlen)
    - ft_strcpy (man 3 strcpy)
    - ft_strcmp (man 3 strcmp)
    - ft_write (man 2 write)
    - ft_read (man 2 read)
    - ft_strdup (man 3 strdup, you can call to malloc)

- You must check for errors during syscalls and properly set them when needed
- Your code must set the variable errno properly
- For that, you are allowed to call the extern ___error or errno_location

# Bonus Part

You can rewrite these functions in asm. The linked list function will use the following
structure:

```c
typedef struct      s_list
{
    void            *data;
    struct s_list   *next;
}                   t_list;
```

- ft_atoi_base (like the one in the piscine)
- ft_list_push_front (like the one in the piscine)
- ft_list_size (like the one in the piscine)
- ft_list_sort (like the one in the piscine)
- ft_list_remove_if (like the one in the piscine)
