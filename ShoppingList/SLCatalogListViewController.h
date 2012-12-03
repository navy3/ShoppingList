//
//  SLCatalogListViewController.h
//  ShoppingList
//
//  Created by  on 12-6-22.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLItemDetailViewController.h"

@protocol SLCatalogListDelegate;

@interface SLCatalogListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SLDetailDelegate>
{
    id<SLCatalogListDelegate> delegate;
}

@property (nonatomic, assign) id<SLCatalogListDelegate> delegate;

@end

@protocol SLCatalogListDelegate <NSObject>

@optional

- (void)selectedItems:(NSMutableArray *)arr withRootCtrl:(UIViewController *)ctrl;

@end