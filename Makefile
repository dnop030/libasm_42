LIB_NAME = libasm.a

MAN_SRC = ft_write.s \

BONUS_SRC =

# src dir
DIR = src

# output dir
OUTPUT_DIR = output

# AS compiler
AS = nasm
ASFLAGS = -f elf64

# C compiler
CC = clang-15
CFLAGS = -Wall -Wextra -Werror

# Linker lib
LINKER = ar rcs

MAN_ASM_OBJ = $(addprefix $(DIR)/, $(MAN_SRC:.s=.o))

# Rules
all: $(LIB_NAME)

$(LIB_NAME):$(MAN_ASM_OBJ)
	$(LINKER) $(LIB_NAME) $(OUTPUT_DIR)/$(subst $(DIR)/,,$(MAN_ASM_OBJ))

%.o:%.s
	mkdir -p $(OUTPUT_DIR)
	$(AS) $(ASFLAGS) $< -o $(OUTPUT_DIR)/$(subst $(DIR)/,,$@)

test: $(LIB_NAME)


clean:
	rm -rf $(OUTPUT_DIR)

fclean: clean
	rm $(LIB_NAME)

re: clean all

.PHONY: all clean fclean re
