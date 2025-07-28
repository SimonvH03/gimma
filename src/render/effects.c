/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   effects.c                                          :+:    :+:            */
/*                                                     +:+                    */
/*   By: simon <svan-hoo@student.codam.nl>            +#+                     */
/*                                                   +#+                      */
/*   Created: 2025/07/28 14:58:21 by simon         #+#    #+#                 */
/*   Updated: 2025/07/28 19:53:27 by simon         ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include "gimma.h"

uint32_t
	colour_blend(
		uint32_t colour_a,
		uint32_t colour_b,
		float level)
{
	t_colour_construct	a;
	t_colour_construct	b;
	t_colour_construct	result;
	float				inverse;

	level = ft_clampf(level, 0, 1);
	inverse = 1 - level;
	a.value = colour_a;
	b.value = colour_b;
	result.r = (a.r * inverse + b.r * level);
	result.g = (a.g * inverse + b.g * level);
	result.b = (a.b * inverse + b.b * level);
	result.a = (a.a * inverse + b.a * level);
	return (result.value);
}

// void
// 	effects_shader(
// 		mlx_image_t	*image,
// 		uint32_t x,
// 		uint32_t y,
// 		void *param)
// {
// 	const t_window	*window = param;
// 	float			dim_factor;

// 	(void)window;
// 	((uint32_t *)image->pixels)[y * image->width + x]
// 		= colour_blend(((uint32_t *)image->pixels)[y * image->width + x],
// 			0xFF000000, ft_clamp(255 * dim_factor, 0, 255));
// }
