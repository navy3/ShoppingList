//
//  SLHelper.m
//  ShoppingList
//
//  Created by  on 12-6-23.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLHelper.h"

@implementation SLHelper

+ (void)registerAllDefaults
{
	NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"0", kIconKey,
                                   @"0", kSelectedKey,
                                   nil];
	
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveBadgeNumber:(int)i
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:i];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:i] forKey:kIconKey];
}

+ (int)badgeNumber
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kIconKey] intValue];
}

+ (void)saveSelectedIndex:(int)i
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:i] forKey:kSelectedKey]; 
}

+ (int)selectedIndex
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kSelectedKey] intValue];
}

+ (UIImage *)imageWithIndex:(int)i
{
	if (0 == i) 
		return [UIImage imageNamed:@"shopping_cart.png"];
	else if(1 == i)
		return [UIImage imageNamed:@"shopping_cart_yellow.png"];
	else if(2 == i)
		return [UIImage imageNamed:@"shopping_cart_red.png"];
	else if(3 == i)
		return [UIImage imageNamed:@"shopping_cart_blue.png"];
	else
		return [UIImage imageNamed:@"shopping_cart_green.png"];
}
@end
