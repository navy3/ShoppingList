//
//  AppDelegate.h
//  ShoppingList
//
//  Created by  on 12-6-15.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdWhirlDelegateProtocol.h"

@class AdWhirlView;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,AdWhirlDelegate>
{
    AdWhirlView *adView;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, retain) AdWhirlView *adView;

@end
