/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   render.h                                           :+:    :+:            */
/*                                                     +:+                    */
/*   By: simon <svan-hoo@student.codam.nl>            +#+                     */
/*                                                   +#+                      */
/*   Created: 2024/08/26 23:06:35 by simon         #+#    #+#                 */
/*   Updated: 2025/07/28 16:08:03 by simon         ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#ifndef RENDER_H
# define RENDER_H
# include "MLX42/MLX42.h"

// ratio of wall height / width
# define CAMERA_PLANE		1

typedef union u_colour_construct
{
	uint32_t	value;
	struct
	{
		uint8_t	a;
		uint8_t	b;
		uint8_t	g;
		uint8_t	r;
	};
}	t_colour_construct;

enum	e_hit_axis
{
	ha_horizontal,
	ha_vertical
};

typedef struct s_column
{
	int32_t			half_height;
	int32_t			start;
	int32_t			end;
	mlx_texture_t	*texture;
	float			x;
	float			step;
	float			tex_y;
}	t_column;

typedef struct s_ray
{
	uint32_t		pos_x;
	uint32_t		pos_y;
	float			camera_x;
	float			dir_x;
	float			dir_y;
	float			step_x;
	float			step_y;
	float			total_x;
	float			total_y;
	float			start_x;
	float			start_y;
	float			partial;
	float			distance;
	int16_t			hit_cell;
	int16_t			faced_cell;
	short			sign_x;
	short			sign_y;
	bool			hit_type;
}	t_ray;

#endif