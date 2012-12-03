//
//  FGSingleChooseViewController.h
//  FreeGo
//
//  Created by navy on 11-11-5.
//  Copyright 2011 freelancer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FGSingleChooseDelegate;

@interface FGSingleChooseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	NSArray			*dataArray;
	UITableView		*tbView;
	int				checkedRow;
	
	id<FGSingleChooseDelegate> delegate;
}

@property (nonatomic, assign) id<FGSingleChooseDelegate> delegate;
@property (nonatomic, retain) NSArray *dataArray;

- (id)initWithArray:(NSArray *)arr;

- (void)loadWithIndex:(int)index;

@end

@protocol FGSingleChooseDelegate<NSObject>

- (void)didChooseString:(NSString *)str rootController:(UIViewController *)ctrl;

@end
