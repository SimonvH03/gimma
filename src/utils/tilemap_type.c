/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   tilemap_type.c                                     :+:    :+:            */
/*                                                     +:+                    */
/*   By: simon <svan-hoo@student.codam.nl>            +#+                     */
/*                                                   +#+                      */
/*   Created: 2025/04/19 23:17:12 by simon         #+#    #+#                 */
/*   Updated: 2025/07/28 13:47:34 by simon         ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include "gimma.h"

bool
	is_door(const int16_t cell)
{
	const char	type = get_type(cell);

	return ((bool)(type == 'd' || type == 'D'));
}

bool
	is_wall(const int16_t cell)
{
	const char	type = get_type(cell);

	return ((bool)(type > '0' && type <= '9'));
}
