//
//  UIColor+TagColors.m
//  wymg
//
//  Created by Maxim on 9/22/13.
//  Copyright (c) 2013 Maxim. All rights reserved.
//

#import "UIColor+TagColors.h"

@implementation UIColor (TagColors)

+ (UIColor *)greenTagColor
{
	return [UIColor colorWithRed:0.2980 green:0.8509 blue:0.3921 alpha:1.000];
}

+ (UIColor *)greenTagColor:(CGFloat)alpha
{
	return [UIColor colorWithRed:0.2980 green:0.8509 blue:0.3921 alpha:alpha];
}

+ (UIColor *)yellowTagColor
{
	return [UIColor colorWithRed:1 green:0.8588 blue:0.298 alpha:1.000];
}

+ (UIColor *)yellowTagColor:(CGFloat)alpha
{
	return [UIColor colorWithRed:1 green:0.8588 blue:0.298 alpha:alpha];
}

+ (UIColor *)redTagColor
{
	return [UIColor colorWithRed:1 green:0.3568 blue:0.2156 alpha:1.000];
}

+ (UIColor *)redTagColor:(CGFloat)alpha
{
	return [UIColor colorWithRed:1 green:0.3568 blue:0.2156 alpha:alpha];
}

@end
