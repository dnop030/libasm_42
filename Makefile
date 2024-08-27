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

# Mandatory sources
MAN_SRC = ft_write.s \
			ft_strlen.s \
			ft_strcmp.s \
			ft_strcpy.s \
			ft_read.s \
			ft_strdup.s

# Bonus sources
BONUS_SRC = ft_atoi_base.s \
			ft_list_push_front.s \
			ft_list_size.s \
			# ft_list_remove_if.s \
			# ft_list_sort.s

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
BONUS_ASM_OBJ = $(addprefix $(BONUS_OUTPUT_DIR)/, $(BONUS_SRC:.s=.o))
MAIN_BONUS_OBJ = $(BONUS_OUTPUT_DIR)/$(BONUS_MAIN:.c=.o)

# Rules
all: $(LIB_NAME)

$(LIB_NAME): $(MAN_ASM_OBJ)
	@$(LINKER) $(LIB_NAME) $(MAN_ASM_OBJ)
	@echo "Mandatory Lib Done!"

$(OUTPUT_DIR)/%.o: $(DIR)/%.s
	@mkdir -p $(OUTPUT_DIR)
	@$(AS) $(ASFLAGS) -g $< -o $@

$(MAIN_OBJ): $(DIR)/$(MAIN)
	@mkdir -p $(OUTPUT_DIR)
	@$(CC) $(CFLAGS) -g -c $< -o $@
	@echo "Main test Lib Done!"

test: all $(MAIN_OBJ)
	@$(CC) -o $(NAME) $(CFLAGS) $(MAIN_OBJ) -L. -lasm
	@echo "READY TO TEST MANDATORY"

bonus: $(BONUS_LIB_NAME)

$(BONUS_LIB_NAME): $(MAN_ASM_OBJ) $(BONUS_ASM_OBJ)
	$(LINKER) $(BONUS_LIB_NAME) $(MAN_ASM_OBJ) $(BONUS_ASM_OBJ)
	@echo "Bonus Lib Done!"

$(BONUS_OUTPUT_DIR)/%.o: $(BONUS_DIR)/%.s
	mkdir -p $(BONUS_OUTPUT_DIR)
	$(AS) $(ASFLAGS) -g $< -o $@

$(MAIN_BONUS_OBJ): $(BONUS_DIR)/$(BONUS_MAIN)
	@mkdir -p $(BONUS_OUTPUT_DIR)
	@$(CC) $(CFLAGS) -g -c $< -o $@
	@echo "Main Bonus test Lib Done!"

test_bonus: bonus $(MAIN_BONUS_OBJ)
	$(CC) -o $(BONUS_NAME) $(CFLAGS) -g $(MAIN_BONUS_OBJ) -L. -lasm

clean:
	@rm -rf $(OUTPUT_DIR)
	@rm -f $(LIB_NAME)
	@echo "DELETED LIB"

fclean: clean
	@rm -f $(NAME)
	@rm -f $(BONUS_NAME)
	@echo "DELETED ALL"

re: clean all

re_test: fclean all

re_bonus: fclean test_bonus

.PHONY: all clean fclean re
