//
//  SLTemplateViewController.m
//  ShoppingList
//
//  Created by  on 12-6-19.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLTemplateViewController.h"
#import "SLFileObject.h"

@interface SLTemplateViewController ()

@property (nonatomic, retain) UITableView *tbView;

@end

@implementation SLTemplateViewController

@synthesize tbView;

- (void)createTableView
{
	if( tbView )
		return ;
	
	self.tbView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - AdViewFrame) style:UITableViewStylePlain] autorelease];
	tbView.scrollEnabled = YES;
	tbView.alwaysBounceVertical = YES;
	tbView.delegate = self;
	tbView.dataSource = self;
	tbView.scrollsToTop = YES;
    tbView.backgroundColor = [UIColor whiteColor];
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

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[SLFileObject sharedInstance] templateArray] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = Nav_Color;
    }
    
    NSDictionary *dict = [[[SLFileObject sharedInstance] templateArray] objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:kSLNameKey];
    
    NSArray *arr = [dict objectForKey:kSLValueKey];
    if (0 == [arr count]) {
        //cell.detailTextLabel.text = NSLocalizedString(@"SL_No_Item", );
    }
    else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",[arr count]];
    }
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source.
		[[[SLFileObject sharedInstance] templateArray] removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}     
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"tab3.png"];
        self.title = NSLocalizedString(@"SL_Tab3_Title", );
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = Nav_Color;
    self.view.backgroundColor = Gray_Color;

    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SL_Template_New", ) 
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self 
                                                                action:@selector(addAction:)];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
    
    [self createTableView];
}

- (void)addAction:(id)sender
{
    FGTextFieldViewController *tx = [[FGTextFieldViewController alloc] init];
    tx.title = NSLocalizedString(@"SL_Template_New", );
    tx.promptTitle = tx.title;
    tx.delegate = self;
    [self.navigationController pushViewController:tx animated:YES];
    [tx release];
}

-(void)didInputTextField:(NSString *)text rootController:(UIViewController *)ctrl
{
    [[SLFileObject sharedInstance] addNewTemplate:text];
    [tbView reloadData];
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
