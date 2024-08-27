# Registers

call-clobbered registers: volatile resgisters -> don't need to set back

call-preserved registers: non-volatile registers -> need to set back

```asm
; call-clobbered
rax     ;temp register; return value
rcx     ;used to pass 4th argument to functions
rdx     ;used to pass 3rd argument to functions
rsi     ;used to pass 2nd argument to functions
rdi     ;used to pass 1nd argument to functions
r8      ;used to pass 5nd argument to functions
r9      ;used to pass 6nd argument to functions
r10-r11 ;temporary

; call-preserved
rbx
rsp     ;stack pointer
rbp     ;base pointer
r12-r15

```
## Arguments
arguments to a function is pass as such for the 6 registers
the rest is push to the stack
same for accepting and sending arguments
```asm
rdi, rsi ,rdx, rcx, r8, r9
```

## System calls

eflags will be set based on the result of the system call
no need to compare to set flag again

```asm
mov rax, 1 ; system call number
mov rdi, 1 ; first argument
mov rsi, msg ; second argument
mov rdx, msg_len ; third argument
syscall ; call the kernel
```
[Linux System Call Table](https://www.chromium.org/chromium-os/developer-library/reference/linux-constants/syscalls/)

## errno_location

```asm
syscall
cmp		rax, -1						; compare result from of output syscall in rax
jg		return						; if success return 0. if not, do next process
push	rax							; keep error status in stack
call	__errno_location wrt ..plt	; errno_location return to rax
pop		rdx							; pop return error of syscall to whatever reg
neg		rdx
mov		byte [rdx], dl
```

## Full register table

| 64-bit | 32-bit | 16-bit | 8-bit |
|--------|--------|--------|-------|
| rax    | eax    | ax     | al    |
| rbx    | ebx    | bx     | bl    |
| rcx    | ecx    | cx     | cl    |
| rdx    | edx    | dx     | dl    |
| rdi    | edi    | di     | dl    |
| rbp    | ebp    | bp     | bpl   |
| rsp    | esp    | sp     | spl   |
| r8     | r8d    | r8w    | r8b   |
| r...   | r...d  | r...w  | r...b |
| r15    | r15d   | r15w   | r15b  |

# Flag

| bit | name | description           |
|-----|------|-----------------------|
| 0   | CF   | Carry flag            |
| 2   | PF   | Parity flag           |
| 4   | AE   | Auxilliary carry flag |
| 6   | ZF   | Zero flag             |
| 7   | SF   | Sign flag             |
| 8   | TF   | Trap flag             |
| 9   | IF   | Interrupt flag        |
| 10  | DF   | Direction flag        |
| 11  | OF   | Signed overflow flag  |

# Operatiors

```asm
mov rbx, 123 ; rbx = 123
mov rax, rbx ; rax = rbx
add rbx, rcx ; rbx += rcx
sub rbx, rdx ; rbx -= rdx
mul rbx      ; rax *= rbx (multiplication is always done on rax)
div rdx      ; rax /= rdx (division is always done on rax)
```

# Memory

```asm
mov rax, [rbx] ; eax = *ebx
mov [rbx], rax ; *ebx = eax
```

# Stack

```asm
push rax ; push eax to the stack
pop rax  ; pop eax from the stack
```


## Jump instructions
```asm
jmp A       ; jump to A
```
### Comparison jump
```asm
je A, B     ; jupm if equal ==
jne A, B    ; jupm if not equal !=
jg A, B     ; jupm if greater >
jge A, B    ; jupm if greater or equal >=
jl A, B     ; jupm if less <
jle A, B    ; jupm if less or equal <=
```

### Test jump
```asm
test rax, rbx ; set flags based on rax & rbx
jz A          ; jump if zero flag is set
jnz A         ; jump if zero flag is not set
```

## PIE

```asm
; PIE
; 1. compile with -fPIE
; 2. link with -pie
; 3. run with ASLR disabled
; add `wrt ..plt` to libc function calls
```

# Debugging with gdb
Make sure you compile with `-g` flag

```bash
gdb ./a.out # start gdb

# set breakpoint
break <func> # or b <func>

# run
run # or r

# enable tui mode
tui enable # or tui e
layout regs # recommended

# step into
step # or s

# step over
next # or n

# continue
continue # or c

# see all registers
info registers # or i r

# see some registers
info registers rax rbx rcx rdx # or i r rax rbx rcx rdx

# see memory
x/x $rsp # or x/x $sp

# see memory as char
x/c $rsp # or x/c $sp

# see memory as string
x/s $rsp # or x/s $sp

# see memory as 32-bit
x/w $rsp # or x/w $sp

# see memory as 16-bit
x/h $rsp # or x/h $sp

# see memory as 8-bit
x/b $rsp # or x/b $sp

# see memory as 64-bit
x/g $rsp # or x/g $sp

# see memory as pointer
x/gx $rsp # or x/gx $sp

# see memory as float
x/f $rsp # or x/f $sp

# see memory as double
x/d $rsp # or x/d $sp

# see memory as quad
x/t $rsp # or x/t $sp

# see memory as octal
x/o $rsp # or x/o $sp

# see memory as binary
x/a $rsp # or x/a $sp

# see memory as address
x/i $rsp # or x/i $sp

# see multiple memory
x/10x $rsp # or x/10x $sp

```
