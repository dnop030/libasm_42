;ft_strlen.s
;size_t strlen(const char *s)


section .text

;Register usage:
;$rdi - pointer to input string / return value
;$rax - counter for length of string

global ft_strlen

ft_strlen:
    mov rax, 0              ; reset counter

    jmp loop                ; whhile (*(s + counter) != 0)
inc_cnt:                    ; {
    inc rax                 ;   counter++
loop:                       ;
    cmp byte [rdi + rax], 0 ;
    jne inc_cnt             ; }

    ret
