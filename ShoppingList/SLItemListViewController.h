//
//  SLItemListViewController.h
//  ShoppingList
//
//  Created by  on 12-6-21.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLItemDetailViewController.h"

@interface SLItemListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SLDetailDelegate>
{
    NSMutableArray *dataArray;
    int selectedIndex;
}

@property (nonatomic, assign) NSMutableArray *dataArray;

@end
