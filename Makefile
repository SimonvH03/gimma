MAKEFLAGS	+=	-r -R

NAME		=	cub3D

CC			=	cc
CFLAGS		=	-Wall -Werror -Wextra -MMD -MP

LFTDIR		=	libft
LIBFT		:=	$(LFTDIR)/libft.a

LMLXDIR		=	MLX42
LIBMLX		:=	$(LMLXDIR)/build/libmlx42.a
MLXFLAGS	=	-ldl -lglfw -pthread -lm

INCLDIR		=	. ./include MLX42/include libft
INCLUDE		:=	$(addprefix -I , $(INCLDIR))

MANSRCDIR	=	mandatory.src
MANSRC		:=	$(MANSRCDIR)/main.c \
				$(MANSRCDIR)/draw_texture_column.c \
				$(MANSRCDIR)/error.c \
				$(MANSRCDIR)/keyboard_controls.c \
				$(MANSRCDIR)/raycast.c \
				$(MANSRCDIR)/init_parse/init_game.c \
				$(MANSRCDIR)/init_parse/init_player.c \
				$(MANSRCDIR)/init_parse/init_window.c \
				$(MANSRCDIR)/init_parse/perimeter_check.c \
				$(MANSRCDIR)/init_parse/read_elements.c \
				$(MANSRCDIR)/init_parse/read_map.c \
				$(MANSRCDIR)/internal_utils/allocation_list.c \
				$(MANSRCDIR)/internal_utils/arithmetic.c \
				$(MANSRCDIR)/internal_utils/gridmap_iter.c \
				$(MANSRCDIR)/internal_utils/modlx.c \
				$(MANSRCDIR)/internal_utils/normalize_vector2.c \
				$(MANSRCDIR)/internal_utils/tilemap_cell.c

BONUSSRCDIR	=	src
BONUSSRC	:=	$(BONUSSRCDIR)/main.c \
				$(BONUSSRCDIR)/error.c \
				$(BONUSSRCDIR)/gamestate/door_animation.c \
				$(BONUSSRCDIR)/gamestate/update_frametime.c \
				$(BONUSSRCDIR)/gamestate/weapon_animation.c \
				$(BONUSSRCDIR)/init/init_doors.c \
				$(BONUSSRCDIR)/init/init_game.c \
				$(BONUSSRCDIR)/init/init_hud.c \
				$(BONUSSRCDIR)/init/init_menu.c \
				$(BONUSSRCDIR)/init/init_player.c \
				$(BONUSSRCDIR)/init/init_weapon.c \
				$(BONUSSRCDIR)/init/init_window.c \
				$(BONUSSRCDIR)/init/new_images_bigmap.c \
				$(BONUSSRCDIR)/init/new_images_minimap.c \
				$(BONUSSRCDIR)/init/perimeter_check.c \
				$(BONUSSRCDIR)/init/read_elements.c \
				$(BONUSSRCDIR)/init/read_map.c \
				$(BONUSSRCDIR)/init/scalable.c \
				$(BONUSSRCDIR)/render/cast_ray.c \
				$(BONUSSRCDIR)/render/draw_texture_column.c \
				$(BONUSSRCDIR)/render/raycast.c \
				$(BONUSSRCDIR)/render/update_bigmap.c \
				$(BONUSSRCDIR)/render/update_minimap.c \
				$(BONUSSRCDIR)/user_interface/keyboard_controls.c \
				$(BONUSSRCDIR)/user_interface/keyhooks.c \
				$(BONUSSRCDIR)/user_interface/mouse_controls.c \
				$(BONUSSRCDIR)/user_interface/player_interaction.c \
				$(BONUSSRCDIR)/user_interface/select_button.c \
				$(BONUSSRCDIR)/user_interface/view_manager.c \
				$(BONUSSRCDIR)/utils/allocation_list.c \
				$(BONUSSRCDIR)/utils/arithmetic_float.c \
				$(BONUSSRCDIR)/utils/arithmetic_int.c \
				$(BONUSSRCDIR)/utils/gridmap_iter.c \
				$(BONUSSRCDIR)/utils/hudmap_setget_ability.c \
				$(BONUSSRCDIR)/utils/image_iter.c \
				$(BONUSSRCDIR)/utils/menu_scene_set_ability.c \
				$(BONUSSRCDIR)/utils/modlx.c \
				$(BONUSSRCDIR)/utils/normalize_vector2.c \
				$(BONUSSRCDIR)/utils/tilemap_cell.c \
				$(BONUSSRCDIR)/utils/tilemap_type.c \
				$(BONUSSRCDIR)/utils/transpose_texture.c

BUILD		?=	bonus
MODE		?=	fast

ifeq ($(BUILD),mandatory)
	CFLAGS	+=	-DNBONUS
	SRCDIR	:=	$(MANSRCDIR)
	SRC		:=	$(MANSRC)
else
	CFLAGS	+=	-DBONUS
	SRCDIR	:=	$(BONUSSRCDIR)
	SRC		:=	$(BONUSSRC)
	NAME	:=	$(NAME)_bonus
endif

ifeq ($(MODE),debug)
	CFLAGS	+=	-g
	NAME	:=	$(NAME)_debug
else
	CFLAGS	+=	-O3
endif

BUILDDIR	:=	build/$(BUILD)/$(MODE)

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
	rm -f $(NAME)_bonus
	rm -f $(NAME)_bonus_debug
	make -C $(LFTDIR) fclean
	rm -rf $(LMLXDIR)/build

re:		clean all
