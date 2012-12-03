//
//  AppDelegate.m
//  ShoppingList
//
//  Created by  on 12-6-15.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "AppDelegate.h"

#import "SLQuickViewController.h"
#import "SLListsViewController.h"
#import "SLTemplateViewController.h"
#import "SLCatalogViewController.h"
#import "SLSettingsViewController.h"

#import "SLFileObject.h"

#import "AdWhirlView.h"
#import "AdWhirlView+.h"
#import "AdWhirlLog.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize adView;

- (void)dealloc
{
    SL_RELEASE(adView);
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
//    UIViewController *viewController1, *viewController2;
//
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        viewController1 = [[[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil] autorelease];
//        viewController2 = [[[SecondViewController alloc] initWithNibName:@"SecondViewController_iPhone" bundle:nil] autorelease];
//    } else {
//        viewController1 = [[[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil] autorelease];
//        viewController2 = [[[SecondViewController alloc] initWithNibName:@"SecondViewController_iPad" bundle:nil] autorelease];
//    }
    
    SLQuickViewController *quick = [[SLQuickViewController alloc] init];
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:quick];
    
    SLListsViewController *list = [[SLListsViewController alloc] init];
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:list];
    
    SLTemplateViewController *temp = [[SLTemplateViewController alloc] init];
    UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:temp];
    
    SLCatalogViewController *ca = [[SLCatalogViewController alloc] init];
    UINavigationController *nc4 = [[UINavigationController alloc] initWithRootViewController:ca];
    
    SLSettingsViewController *settings = [[SLSettingsViewController alloc] init];
    UINavigationController *nc5 = [[UINavigationController alloc] initWithRootViewController:settings];
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nc1,nc2,nc4,nc5, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    [quick release];
    [nc1 release];
    
    [list release];
    [nc2 release];
    
    [temp release];
    [nc3 release];
    
    [ca release];
    [nc4 release];
    
    [settings release];
    [nc5 release];
    
    [SLFileObject sharedInstance];
    
//    self.adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
//    self.adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
//    [self.tabBarController.view addSubview:self.adView];
//    adView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50 - 49, [UIScreen mainScreen].bounds.size.width, 50);
//    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[SLFileObject sharedInstance] saveList];

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[SLFileObject sharedInstance] saveList];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/
#pragma mark AdWhirlDelegate methods

- (NSString *)adWhirlApplicationKey {
	return kSampleAppKey;
}

- (UIViewController *)viewControllerForPresentingModalView {
	return self.tabBarController;
}

- (NSURL *)adWhirlConfigURL {
	return [NSURL URLWithString:kSampleConfigURL];
}

- (NSURL *)adWhirlImpMetricURL {
	return [NSURL URLWithString:kSampleImpMetricURL];
}

- (NSURL *)adWhirlClickMetricURL {
	return [NSURL URLWithString:kSampleClickMetricURL];
}

- (NSURL *)adWhirlCustomAdURL {
	return [NSURL URLWithString:kSampleCustomAdURL];
}

- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView {
	[UIView beginAnimations:@"AdResize" context:nil];
	[UIView setAnimationDuration:0.7];
	CGSize adSize = [adView actualAdSize];
	CGRect newFrame = adView.frame;
	newFrame.size.height = adSize.height;
	newFrame.size.width = adSize.width;
	newFrame.origin.x = 0;
	newFrame.origin.y = [UIScreen mainScreen].bounds.size.height - 50 - 49;
	adView.frame = newFrame;
	[UIView commitAnimations];
}


- (void)adWhirlDidFailToReceiveAd:(AdWhirlView *)adWhirlView usingBackup:(BOOL)yesOrNo {
	
}

- (void)adWhirlReceivedRequestForDeveloperToFufill:(AdWhirlView *)adWhirlView {
	UILabel *replacement = [[UILabel alloc] initWithFrame:kAdWhirlViewDefaultFrame];
	replacement.backgroundColor = [UIColor redColor];
	replacement.textColor = [UIColor whiteColor];
	replacement.textAlignment = UITextAlignmentCenter;
	replacement.text = @"Generic Notification";
	[adWhirlView replaceBannerViewWith:replacement];
	[replacement release];
	[UIView beginAnimations:@"AdResize" context:nil];
	[UIView setAnimationDuration:0.7];
	CGSize adSize = [adView actualAdSize];
	CGRect newFrame = adView.frame;
	newFrame.size.height = adSize.height;
	newFrame.size.width = adSize.width;
	newFrame.origin.x = adSize.width/2;
	adView.frame = newFrame;
	[UIView commitAnimations];
}

- (void)adWhirlReceivedNotificationAdsAreOff:(AdWhirlView *)adWhirlView {
}


- (void)adWhirlDidReceiveConfig:(AdWhirlView *)adWhirlView {
}

@end
