# Name of executable
NAME = asmr

# Name of library
LIB_NAME = libasm.a

# src file
MAIN = main.c

MAN_SRC = ft_write.s \
			ft_strlen.s

# src dir
DIR = src

# output dir
OUTPUT_DIR = output

# AS compiler
AS = nasm
ASFLAGS = -f elf64

# C compiler
CC = clang-15
CFLAGS = -Wall -Wextra -Werror -m64

# Linker lib
LINKER = ar rcs

MAN_ASM_OBJ = $(addprefix $(OUTPUT_DIR)/, $(MAN_SRC:.s=.o))
MAIN_OBJ = $(OUTPUT_DIR)/$(MAIN:.c=.o)

# Rules
all: $(LIB_NAME)

$(LIB_NAME): $(MAN_ASM_OBJ)
	@$(LINKER) $(LIB_NAME) $(MAN_ASM_OBJ)
	@echo "Mandatory Lib Done!"

$(OUTPUT_DIR)/%.o: $(DIR)/%.s
	@mkdir -p $(OUTPUT_DIR)
	@$(AS) $(ASFLAGS) $< -o $@

$(MAIN_OBJ): $(DIR)/$(MAIN)
	@mkdir -p $(OUTPUT_DIR)
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo "Main test Lib Done!"

test: all $(MAIN_OBJ)
	@$(CC) -o $(NAME) $(CFLAGS) $(MAIN_OBJ) -L. -lasm
	@echo "READY TO TEST MANDATORY"

clean:
	@rm -rf $(OUTPUT_DIR)
	@rm -f $(LIB_NAME)
	@echo "DELETED LIB"

fclean: clean
	@rm -f $(NAME)
	@echo "DELETED ALL"

re: clean all

.PHONY: all clean fclean re
