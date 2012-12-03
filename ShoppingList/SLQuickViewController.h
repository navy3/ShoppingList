//
//  SLQuickViewController.h
//  ShoppingList
//
//  Created by  on 12-6-15.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLItemDetailViewController.h"
#import "SLCatalogListViewController.h"
#import "SLItemCell.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SLQuickViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SLCatalogListDelegate,SLItemCellDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate>

@end
