;size_t strlen(const char *s)

section .text

global ft_strlen

ft_strlen:
    mov rax, 0              ; reset counter
    jmp loop
inc_cnt:
    inc rax                 ; inc counter
loop:
    cmp byte [rdi + rax], 0 ; whhile (*(s + counter) != 0)
    jne inc_cnt             ;

    ret
