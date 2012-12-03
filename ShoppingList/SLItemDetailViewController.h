//
//  SLItemDetailViewController.h
//  ShoppingList
//
//  Created by  on 12-6-21.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLItem.h"
#define Text_Font   17.0f

@protocol SLDetailDelegate<NSObject>

@optional

- (void)addItem:(NSDictionary *)dict withRootCtrl:(UIViewController *)ctrl;

@end

@interface SLItemDetailViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *ft1;
    UITextField *ft2;
    UITextField *ft3;
    
    id<SLDetailDelegate> delegate;
    
    SLItem *item;
    
}
//@property (nonatomic, retain) SLItem *item;
@property (nonatomic, retain) UITextField *tf1;
@property (nonatomic, retain) UITextField *tf2;
@property (nonatomic, retain) UITextField *tf3;
@property (nonatomic, retain) id<SLDetailDelegate> delegate;

- (void)setItem:(SLItem *)item;

- (void)showNumber;

@end
