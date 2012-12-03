//
//  SLItemDetailViewController.m
//  ShoppingList
//
//  Created by  on 12-6-21.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLItemDetailViewController.h"

@interface SLItemDetailViewController ()


@end

@implementation SLItemDetailViewController

@synthesize tf1,tf2,tf3,delegate;

- (void)dealloc
{
    SL_RELEASE(tf1);
    SL_RELEASE(tf2);
    SL_RELEASE(tf3);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self buildUI];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																			  target:self
																			  action:@selector(doneAction:)];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
}

- (void)doneAction:(id)sender
{
    float f = [tf2.text floatValue];
    if (0.00 == f || [tf1.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:NSLocalizedString(@"SL_Alert_Error", ) 
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"SL_Alert_Cancel", ) 
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else {
        item.price = [NSString stringWithFormat:@"%.2f",f];
        item.name = tf1.text;
        if (tf3) {
            item.quantity = tf3.text;
        }
        
        if ([delegate respondsToSelector:@selector(addItem:withRootCtrl:)]) {
            [delegate addItem:[item itemDictionary] withRootCtrl:self];
        }
    }
}

- (void)setItem:(SLItem *)slitem
{
    [item release];
    [slitem retain];
    item = slitem;
    tf1.text = item.name;
    tf2.text = item.price;
    tf3.text = item.quantity;
}

- (void)showNumber
{
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width/4, 30)];
	label3.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	label3.textAlignment = UITextAlignmentRight;
	label3.font = [UIFont boldSystemFontOfSize:Text_Font];
	label3.backgroundColor = [UIColor clearColor];
	label3.textColor = [UIColor whiteColor];
	label3.text = NSLocalizedString(@"SL_Detail_Quantity",);
	[self.view addSubview:label3];
	[label3 release];
	
	self.tf3 = [[[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/4 + 20, 100, self.view.bounds.size.width * 3/4 - 40, 30)] autorelease];
    tf3.borderStyle = UITextBorderStyleRoundedRect;
    tf3.backgroundColor = [UIColor whiteColor];
    tf3.textColor = TEXT_BLUE_COLOR;
    tf3.enabled = YES;
	tf3.returnKeyType = UIReturnKeyNext;
    tf3.keyboardType = UIKeyboardTypeNumberPad;
    tf3.font = [UIFont boldSystemFontOfSize:Text_Font];
    tf3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    tf3.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    tf3.delegate = self;
	[self.view addSubview:tf3];

    tf2.returnKeyType = UIReturnKeyNext;
}

- (void)buildUI
{
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	
	UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width/4, 30)];
	label1.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	label1.textAlignment = UITextAlignmentRight;
	label1.font = [UIFont boldSystemFontOfSize:Text_Font];
	label1.backgroundColor = [UIColor clearColor];
	label1.textColor = [UIColor whiteColor];
	label1.text = NSLocalizedString(@"SL_Detail_Name",);
	[self.view addSubview:label1];
	[label1 release];
	
	self.tf1 = [[[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/4 + 20, 20, self.view.bounds.size.width * 3/4 - 40, 30)] autorelease];
    tf1.borderStyle = UITextBorderStyleRoundedRect;
    tf1.backgroundColor = [UIColor whiteColor];
    tf1.textColor = TEXT_BLUE_COLOR;
    tf1.enabled = YES;
	tf1.returnKeyType = UIReturnKeyNext;
    tf1.font = [UIFont boldSystemFontOfSize:Text_Font];
    tf1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    tf1.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    tf1.delegate = self;
	[self.view addSubview:tf1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width/4, 30)];
	label2.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
	label2.textAlignment = UITextAlignmentRight;
	label2.font = [UIFont boldSystemFontOfSize:Text_Font];
	label2.backgroundColor = [UIColor clearColor];
	label2.textColor = [UIColor whiteColor];
	label2.text = NSLocalizedString(@"SL_Detail_Price",);
	[self.view addSubview:label2];
	[label2 release];
	
	self.tf2 = [[[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/4 + 20, 60, self.view.bounds.size.width * 3/4 - 40, 30)] autorelease];
    tf2.borderStyle = UITextBorderStyleRoundedRect;
    tf2.backgroundColor = [UIColor whiteColor];
    tf2.textColor = TEXT_BLUE_COLOR;
    tf2.enabled = YES;
	tf2.returnKeyType = UIReturnKeyDone;
    tf2.font = [UIFont boldSystemFontOfSize:Text_Font];
    tf2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    tf2.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    tf2.delegate = self;
	[self.view addSubview:tf2];
    
    [tf1 becomeFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (tf1 == textField) {
        [tf2 becomeFirstResponder];
    }
    
    if (tf2 == textField) {
        if (tf3) {
            [tf3 resignFirstResponder];
        }
        else {
            [self doneAction:nil];
        }
    }
    
    if (tf3 == textField) {
        [self doneAction:nil];
    }
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
