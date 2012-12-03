//
//  SLSettingsViewController.m
//  ShoppingList
//
//  Created by  on 12-6-20.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLSettingsViewController.h"
#import "SLFileObject.h"
#import "SLHelper.h"

@interface SLSettingsViewController ()

@property (nonatomic, retain) UITableView *tbView;

@end

@implementation SLSettingsViewController

@synthesize tbView;

- (void)createTableView
{
	if( tbView )
		return ;
	
	self.tbView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - AdViewFrame) style:UITableViewStyleGrouped] autorelease];
	tbView.scrollEnabled = YES;
	tbView.alwaysBounceVertical = YES;
	tbView.delegate = self;
	tbView.dataSource = self;
	tbView.scrollsToTop = YES;
    tbView.backgroundColor = [UIColor clearColor];
	tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[tbView setAllowsSelectionDuringEditing:NO];
	[self.view addSubview:tbView];
}

- (void)dealloc
{
    SL_RELEASE(tbView);
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"tab5.png"];
        self.title = NSLocalizedString(@"SL_Tab5_Title", );
    }
    return self;
}

#pragma mark -
#pragma mark Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"SL_Settings_Number", );
}
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[SLFileObject sharedInstance] listArray] count] + 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    if ([SLHelper selectedIndex] == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (0 == indexPath.row) {
        cell.textLabel.text = NSLocalizedString(@"SL_Settings_None", );
    }    
    else if (1 == indexPath.row) {
        cell.textLabel.text = NSLocalizedString(@"SL_Settings_QuickList", );
    }
    else
    {
        NSDictionary *dict = [[[SLFileObject sharedInstance] listArray] objectAtIndex:indexPath.row - 2];
        cell.textLabel.text = [dict objectForKey:kSLNameKey];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [SLHelper saveSelectedIndex:indexPath.row];

    if (0 == indexPath.row) {
        [SLHelper saveBadgeNumber:0];
    }
    else if (1 == indexPath.row) {
        int count = 0;
        
        for (int i = 0; i < [[[SLFileObject sharedInstance] quickArray] count]; i++) {
            NSArray *sub = [[[SLFileObject sharedInstance] quickArray] objectAtIndex:i];
            count += [sub count];
        }
        [SLHelper saveBadgeNumber:count];
    }
    else {
        NSDictionary *dict = [[[SLFileObject sharedInstance] listArray] objectAtIndex:indexPath.row - 2];
        NSArray *arr = [dict objectForKey:kSLValueKey];
        int count = 0;
        
        for (int i = 0; i < [arr count]; i++) {
            NSArray *sub = [arr objectAtIndex:i];
            count += [sub count];
        }
        [SLHelper saveBadgeNumber:count];
    }
    
    [tbView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = Nav_Color;
    self.view.backgroundColor = Gray_Color;

    [self createTableView];
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
