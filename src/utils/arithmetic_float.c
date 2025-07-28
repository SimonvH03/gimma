/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   arithmetic_float.c                                 :+:    :+:            */
/*                                                     +:+                    */
/*   By: simon <svan-hoo@student.codam.nl>            +#+                     */
/*                                                   +#+                      */
/*   Created: 2024/02/23 18:51:01 by svan-hoo      #+#    #+#                 */
/*   Updated: 2025/07/28 19:53:27 by simon         ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include "gimma.h"

float	nearest_power_of_2(float value)
{
	if (value <= 0)
		return (0);
	return (powf(2.0f, roundf(log2f(value))));
}

// return absolute value
float	ft_absf(float value)
{
	if (value < 0)
		return (-value);
	return (value);
}

// return highest value
float	ft_maxf(float a, float b)
{
	if (a < b)
		return (b);
	else
		return (a);
}

// return lowest value
float	ft_minf(float a, float b)
{
	if (a < b)
		return (a);
	else
		return (b);
}

// return polarity of value
short	ft_signf(float value)
{
	if (value < 0)
		return (-1);
	if (value > 0)
		return (1);
	return (0);
}

float	ft_clampf(float value, float lower_bound, float upper_bound)
{
	if (value < lower_bound)
		return (lower_bound);
	if (value > upper_bound)
		return (upper_bound);
	return (value);
}

float	ft_squaref(float value)
{
	return (value * value);
}