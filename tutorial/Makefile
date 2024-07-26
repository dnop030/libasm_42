AS = nasm
ASFLAGS = -f elf64

SRCS = ex00.s\
		ex01.s\
		ex02.s\
		ex03.s\
		ex04.s\
		ex05.s\
		ex06.s\
		ex07.s

OBJ_ASM = $(SRCS:.s=.o)

EXT_SRC = .s
EXT_OBJ = .o

OUTPUT_DIR = output

all: $(OBJ_ASM)

%.o:%.s
	$(AS) $(ASFLAGS) $< -o $(OUTPUT_DIR)/$@
	ld -m elf_x86_64 $(OUTPUT_DIR)/$@ -o $(OUTPUT_DIR)/$(subst $(EXT_OBJ),,$@)
# ld -m elf_x86_64 $(subst $(EXT_SRC),$(EXT_OBJ),$<) -o $(subst $(EXT_OBJ),,$@)

clean:
# rm -rf $(OBJ_ASM)
	rm -rf ./$(OUTPUT_DIR)/*

.PHONY: all clean

# RUN:
# 	ld -m elf64_x86_64 $< -o $@
