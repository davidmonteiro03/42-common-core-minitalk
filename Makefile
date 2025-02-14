# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dcaetano <dcaetano@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/10/24 07:31:26 by dcaetano          #+#    #+#              #
#    Updated: 2025/02/14 16:31:04 by dcaetano         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC                = cc
CFLAGS            = -Wall -Wextra -Werror
RM                = rm -rf

OBJS_DIR          = obj/
INCLUDES_DIR      = includes/

SRCS_SERVER       = server.c
SRCS_CLIENT       = client.c

SRCS_SERVER_BONUS = server_bonus.c
SRCS_CLIENT_BONUS = client_bonus.c

LIBFT_DIR         = libft
LIBFT_NAME        = libft.a

OBJS_SERVER       = $(addprefix $(OBJS_DIR), $(SRCS_SERVER:.c=.o))
OBJS_CLIENT       = $(addprefix $(OBJS_DIR), $(SRCS_CLIENT:.c=.o))

OBJS_SERVER_BONUS = $(addprefix $(OBJS_DIR), $(SRCS_SERVER_BONUS:.c=.o))
OBJS_CLIENT_BONUS = $(addprefix $(OBJS_DIR), $(SRCS_CLIENT_BONUS:.c=.o))

EXEC_SERVER       = server
EXEC_CLIENT       = client

EXEC_SERVER_BONUS = server_bonus
EXEC_CLIENT_BONUS = client_bonus

all: $(EXEC_SERVER) $(EXEC_CLIENT)

bonus: $(EXEC_SERVER_BONUS) $(EXEC_CLIENT_BONUS)

$(OBJS_DIR)%.o: ./%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -I$(INCLUDES_DIR) -c $< -o $@

$(EXEC_SERVER): $(OBJS_SERVER)
	@make -sC $(LIBFT_DIR)
	@$(CC) $(CFLAGS) -I$(INCLUDES_DIR) $^ -o $@ -L$(LIBFT_DIR) -lft

$(EXEC_CLIENT): $(OBJS_CLIENT)
	@make -sC $(LIBFT_DIR)
	@$(CC) $(CFLAGS) -I$(INCLUDES_DIR) $^ -o $@ -L$(LIBFT_DIR) -lft

$(EXEC_SERVER_BONUS): $(OBJS_SERVER_BONUS)
	@make -sC $(LIBFT_DIR)
	@$(CC) $(CFLAGS) -I$(INCLUDES_DIR) $^ -o $@ -L$(LIBFT_DIR) -lft

$(EXEC_CLIENT_BONUS): $(OBJS_CLIENT_BONUS)
	@make -sC $(LIBFT_DIR)
	@$(CC) $(CFLAGS) -I$(INCLUDES_DIR) $^ -o $@ -L$(LIBFT_DIR) -lft

clean:
	@$(RM) $(OBJS_DIR)
	@make -sC $(LIBFT_DIR) clean

fclean: clean
	@$(RM) $(EXEC_SERVER) $(EXEC_CLIENT) $(EXEC_SERVER_BONUS) $(EXEC_CLIENT_BONUS)
	@make -sC $(LIBFT_DIR) fclean

re: fclean all

.PHONY: all clean fclean re
