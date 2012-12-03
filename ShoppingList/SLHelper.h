//
//  SLHelper.h
//  ShoppingList
//
//  Created by  on 12-6-23.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kIconKey @"kIconKey"
#define kSelectedKey @"kSelectedKey"

@interface SLHelper : NSObject

+ (void)registerAllDefaults;

+ (UIImage *)imageWithIndex:(int)i;

+ (void)saveBadgeNumber:(int)i;
+ (int)badgeNumber;

+ (void)saveSelectedIndex:(int)i;
+ (int)selectedIndex;

@end
