# Name of executable
NAME = asmr
BONUS_NAME = bonus_asmr

# Name of library
LIB_NAME = libasm.a
BONUS_LIB_NAME = libasm.a

# src file
MAIN = main.c

# bonus file
BONUS_MAIN = main_bonus.c

# bonus file
BONUS_MAIN = main_bonus.c

# Mandatory sources
MAN_SRC = ft_write.s \
			ft_strlen.s \
			ft_strcmp.s \
			ft_strcpy.s \
			ft_read.s \
			ft_strdup.s

# Bonus sources
BONUS_SRC = ft_atoi_base.c \
			ft_list_push_front.c \
			ft_list_size.c \
			ft_list_remove_if.c \
			ft_list_sort.c

# src dir
DIR = src

# bonus dir
BONUS_DIR = src/bonus

# output dir
OUTPUT_DIR = output
BONUS_OUTPUT_DIR = output

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
BONUS_ASM_OBJ = $(addprefix $(BONUS_OUTPUT_DIR)/, $(BONUS_SRC:.c=.o))
BONUS_OBJ = $(BONUS_OUTPUT_DIR)/$(BONUS_MAIN:.c=.o)

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

bonus: $(BONUS_LIB_NAME)

$(BONUS_LIB_NAME): $(MAN_ASM_OBJ) $(BONUS_ASM_OBJ)
	$(LINKER) $(BONUS_LIB_NAME) $(MAN_ASM_OBJ) $(BONUS_ASM_OBJ)
	echo "Bonus Lib Done!"

$(BONUS_OUTPUT_DIR)/%.o: $(BONUS_DIR)/%.c
	mkdir -p $(BONUS_OUTPUT_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

test_bonus: bonus $(BONUS_OBJ)
	$(CC) -o $(BONUS_NAME) $(CFLAGS) $(BONUS_OBJ) -L. -lasm

clean:
	@rm -rf $(OUTPUT_DIR)
	@rm -f $(LIB_NAME)
	@echo "DELETED LIB"

fclean: clean
	@rm -f $(NAME)
	@rm -f $(BONUS_NAME)
	@echo "DELETED ALL"

re: clean all

.PHONY: all clean fclean re
