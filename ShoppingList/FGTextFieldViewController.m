    //
//  FGTextFieldViewController.m
//  FreeGo
//
//  Created by navy on 11-11-5.
//  Copyright 2011 freelancer. All rights reserved.
//

#import "FGTextFieldViewController.h"

@interface FGTextFieldViewController()

@property (nonatomic, retain) UISegmentedControl *segCtrl;

- (void)createTextField;
- (void)createSegment;

@end


@implementation FGTextFieldViewController

@synthesize textField,delegate,promptTitle,segCtrl;

- (void)createTextField
{
	textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 240, 40)];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.rightViewMode = UITextFieldViewModeWhileEditing;
	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	//textField.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
	if ([promptTitle length]) {
		textField.placeholder = promptTitle;
	}
	else {
		textField.placeholder = self.title;
	}
	textField.textAlignment = UITextAlignmentCenter;
	textField.delegate = self;
	textField.center = CGPointMake(self.view.center.x, 80);
	textField.returnKeyType = UIReturnKeyDone;
	[self.view addSubview:textField];
	[textField becomeFirstResponder];
}

- (void)createSegment
{
    if (segCtrl) 
        return;
    self.segCtrl = [[[UISegmentedControl alloc] initWithItems:
                     [NSArray arrayWithObjects:[UIImage imageNamed:@"shopping_cart.png"], 
                      [UIImage imageNamed:@"shopping_cart_yellow.png"],
                      [UIImage imageNamed:@"shopping_cart_red.png"],
                      [UIImage imageNamed:@"shopping_cart_blue.png"],
                      [UIImage imageNamed:@"shopping_cart_green.png"],nil]] autorelease];
    segCtrl.selectedSegmentIndex = 0;
    segCtrl.frame = CGRectMake(10, 0, self.view.bounds.size.width - 20, 32);
    segCtrl.center = CGPointMake(self.view.center.x, 140);
    [self.view addSubview:segCtrl];
    segCtrl.hidden = YES;
    //[tbView setTableHeaderView:segCtrl];
}

- (void)showSegment
{
    segCtrl.hidden = NO;
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)tf
{
	if ([textField.text length]) {
		[self.navigationController popViewControllerAnimated:YES];
		
		if ([delegate respondsToSelector:@selector(didInputTextField:rootController:)]) {
			[delegate didInputTextField:textField.text rootController:self];
		}
	}
	return YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
	self.navigationItem.rightBarButtonItem = rightItem;
	[rightItem release];
	
	[self createTextField];
    [self createSegment];
}

- (void)doneAction:(id)sender
{
	if ([textField.text length]) {
		[self.navigationController popViewControllerAnimated:YES];
		
		if ([delegate respondsToSelector:@selector(didInputTextField:rootController:)]) {
			[delegate didInputTextField:textField.text rootController:self];
		}
        
        if ([delegate respondsToSelector:@selector(didInputTextField:andIcon:rootController:)]) {
            [delegate didInputTextField:textField.text andIcon:segCtrl.selectedSegmentIndex rootController:self];
        }
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.promptTitle = nil;
	self.textField = nil;
}


- (void)dealloc {
	[promptTitle release];
	[textField release];
    [super dealloc];
}


@end
