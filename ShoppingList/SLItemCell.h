//
//  SLItemCell.h
//  ShoppingList
//
//  Created by  on 12-6-21.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLItem.h"

@protocol SLItemCellDelegate <NSObject>


- (void)updateDict:(NSDictionary *)dict withIndex:(NSIndexPath *)i;

@end

@interface SLItemCell : UITableViewCell
{
    id<SLItemCellDelegate> delegate;
@private
    NSIndexPath *index;
}

@property (nonatomic, assign) id<SLItemCellDelegate> delegate;

- (void)updateCell:(SLItem *)slitem withIndex:(NSIndexPath *)i;

@end

