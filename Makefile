NAME = __NAME_PLACEHOLDER__
CC = gcc
LIBFT = ./libft/libft.a
FT_PRINTF = ./ft_printf/ft_printf.a
CFLAGS = -Wall -Wextra -Werror
DEBUGFLAGS =  -fsanitize=address -g -o __NAME_PLACEHOLDER___debug
LEAKCHECKFLAGS = -g -o __NAME_PLACEHOLDER___leakcheck
SRCF = 

SRC = $(addprefix $(SRCDIR),$(SRCF))
OBJ = $(addprefix $(OBJDIR),$(SRCF:.c=.o))

OBJDIR = ./obj/
SRCDIR = ./src/
LIBDIR = ./libft/
FTPFDIR = ./ft_printf/
INCDIR = ./include/

.PHONY: $(NAME), all, clean, fclean, re, $(LIBFT)

all: $(LIBFT) $(FT_PRINTF) $(NAME)

$(NAME): $(LIBFT) $(FT_PRINTF)
	@echo "Compiling __NAME_PLACEHOLDER__"
	@$(CC) $(CFLAGS) -c -I$(INCDIR) $(SRC)
	@mkdir -p $(OBJDIR)
	@mv $(SRCF:.c=.o) $(OBJDIR)
	@$(CC) $(CFLAGS) -I$(INCDIR) -I$(LIBDIR) $(OBJ) $(LIBFT) $(FT_PRINTF) -o $@
	@echo "__NAME_PLACEHOLDER__: SUCCESS!"

$(LIBFT):
	@make -C $(LIBDIR) all

$(FT_PRINTF): $(LIBFT)
	@make -C $(FTPFDIR) all

clean:
	@echo "Cleaning __NAME_PLACEHOLDER__"
	@rm -rf $(OBJDIR)
	@rm -f __NAME_PLACEHOLDER___debug.dSYM_ 
	@rm -rf __NAME_PLACEHOLDER___debug.dSYM
	@rm -f __NAME_PLACEHOLDER___leakcheck
	@rm -rf __NAME_PLACEHOLDER___leakcheck.dSYM
	@make -C $(LIBDIR) clean
	@make -C $(FTPFDIR) clean

fclean: clean
	@echo "FCleaning __NAME_PLACEHOLDER__"
	@rm -f $(NAME) checker
	@make -C $(LIBDIR) fclean
	@make -C $(FTPFDIR) fclean

re: fclean all

debug: $(LIBFT) $(FT_PRINTF)
	@echo "Compiling __NAME_PLACEHOLDER__ with debugging options"
	$(CC) $(CFLAGS) $(SRC) $(FT_PRINTF) $(LIBFT) -I$(INCDIR) $(DEBUGFLAGS)

leakcheck: $(LIBFT) $(FT_PRINTF)
	@echo "Compiling __NAME_PLACEHOLDER__ for leak checks with valgrind"
	$(CC) $(CFLAGS) $(SRC) $(FT_PRINTF) $(LIBFT) -I$(INCDIR) $(LEAKCHECKFLAGS)
