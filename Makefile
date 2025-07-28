MAKEFLAGS	+=	-r -R

NAME		=	gimma

CC			=	cc
CFLAGS		=	-Wall -Werror -Wextra -MMD -MP

LFTDIR		=	libft
LIBFT		:=	$(LFTDIR)/libft.a

LMLXDIR		=	MLX42
LIBMLX		:=	$(LMLXDIR)/build/libmlx42.a
MLXFLAGS	=	-ldl -lglfw -pthread -lm

INCLDIR		=	. ./include MLX42/include libft
INCLUDE		:=	$(addprefix -I , $(INCLDIR))

SRCDIR		=	src
SRC			:=	$(SRCDIR)/main.c \
				$(SRCDIR)/error.c \
				$(SRCDIR)/gamestate/door_animation.c \
				$(SRCDIR)/gamestate/update_frametime.c \
				$(SRCDIR)/gamestate/weapon_animation.c \
				$(SRCDIR)/init/init_doors.c \
				$(SRCDIR)/init/init_game.c \
				$(SRCDIR)/init/init_hud.c \
				$(SRCDIR)/init/init_menu.c \
				$(SRCDIR)/init/init_player.c \
				$(SRCDIR)/init/init_weapon.c \
				$(SRCDIR)/init/init_window.c \
				$(SRCDIR)/init/new_images_bigmap.c \
				$(SRCDIR)/init/new_images_minimap.c \
				$(SRCDIR)/init/perimeter_check.c \
				$(SRCDIR)/init/read_elements.c \
				$(SRCDIR)/init/read_map.c \
				$(SRCDIR)/init/scalable.c \
				$(SRCDIR)/render/cast_ray.c \
				$(SRCDIR)/render/draw_texture_column.c \
				$(SRCDIR)/render/raycast.c \
				$(SRCDIR)/render/update_bigmap.c \
				$(SRCDIR)/render/update_minimap.c \
				$(SRCDIR)/user_interface/keyboard_controls.c \
				$(SRCDIR)/user_interface/keyhooks.c \
				$(SRCDIR)/user_interface/mouse_controls.c \
				$(SRCDIR)/user_interface/player_interaction.c \
				$(SRCDIR)/user_interface/select_button.c \
				$(SRCDIR)/user_interface/view_manager.c \
				$(SRCDIR)/utils/allocation_list.c \
				$(SRCDIR)/utils/arithmetic_float.c \
				$(SRCDIR)/utils/arithmetic_int.c \
				$(SRCDIR)/utils/gridmap_iter.c \
				$(SRCDIR)/utils/hudmap_setget_ability.c \
				$(SRCDIR)/utils/image_iter.c \
				$(SRCDIR)/utils/menu_scene_set_ability.c \
				$(SRCDIR)/utils/modlx.c \
				$(SRCDIR)/utils/normalize_vector2.c \
				$(SRCDIR)/utils/tilemap_cell.c \
				$(SRCDIR)/utils/tilemap_type.c \
				$(SRCDIR)/utils/transpose_texture.c

MODE		?=	fast

ifeq ($(MODE),debug)
	CFLAGS	+=	-g
	NAME	:=	$(NAME)_debug
else
	CFLAGS	+=	-O3
endif

BUILDDIR	:=	build/$(MODE)

OBJDIR		:=	$(BUILDDIR)
OBJ			:=	$(SRC:$(SRCDIR)%.c=$(OBJDIR)%.o)
DEP			:=	$(OBJ:.o=.d)

.PHONY:	all clean fclean re

all:	$(NAME)

$(NAME): $(OBJ) $(LIBFT) $(LIBMLX)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(OBJ) $(LIBFT) $(LIBMLX) $(MLXFLAGS) -o $@
ifeq ($(MODE),fast)
	strip $(NAME)
endif

$(OBJ): $(OBJDIR)%.o: $(SRCDIR)%.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@

$(LIBFT):
	$(MAKE) -C $(LFTDIR)

$(LIBMLX):
	cmake $(LMLXDIR) -B $(LMLXDIR)/build && make -C $(LMLXDIR)/build -j4

-include $(DEP)

clean:
	rm -rf build
	make -C $(LFTDIR) clean

fclean:	clean
	rm -f $(NAME)
	rm -f $(NAME)_debug
	make -C $(LFTDIR) fclean
	rm -rf $(LMLXDIR)/build

re:		clean all
