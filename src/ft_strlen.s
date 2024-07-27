;size_t strlen(const char *s)

section .text

global ft_strlen

ft_strlen:
    mov rax, 0          ; reset return value
    cmp [rdi + rax], 0  ; if (*s != 0)
    jnz ft_strlen       ;

    ret