//
//  FGTextFieldViewController.h
//  FreeGo
//
//  Created by navy on 11-11-5.
//  Copyright 2011 freelancer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FGTextFieldDelegate;

@interface FGTextFieldViewController : UIViewController<UITextFieldDelegate> {
	UITextField	*textField;
	id<FGTextFieldDelegate> delegate;
	NSString	*promptTitle;
}
@property (nonatomic, copy) NSString *promptTitle;

@property (nonatomic, assign) id<FGTextFieldDelegate> delegate;
@property (nonatomic, retain) UITextField *textField;

- (void)showSegment;

@end

@protocol FGTextFieldDelegate<NSObject>

@optional

-(void)didInputTextField:(NSString *)text rootController:(UIViewController *)ctrl;

-(void)didInputTextField:(NSString *)text andIcon:(int)index rootController:(UIViewController *)ctrl;

@end