//
//  SLCatalogViewController.m
//  ShoppingList
//
//  Created by  on 12-6-19.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLCatalogViewController.h"
#import "SLFileObject.h"
#import "SLItemListViewController.h"

@interface SLCatalogViewController ()

@property (nonatomic, retain) UITableView *tbView;

@end

@implementation SLCatalogViewController

@synthesize tbView;

- (void)dealloc
{
    SL_RELEASE(tbView);
    [super dealloc];
}

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

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[SLFileObject sharedInstance] catalogArray] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		//cell.editingStyle = UITableViewCellEditingStyleInsert;
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    NSDictionary *dict = [[[SLFileObject sharedInstance] catalogArray] objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"NAME"];

    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source.
		[[[SLFileObject sharedInstance] catalogArray] removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}     
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    SLItemListViewController *list = [[SLItemListViewController alloc] init];
    NSDictionary *dict = [[[SLFileObject sharedInstance] catalogArray] objectAtIndex:indexPath.row];
    list.dataArray = [dict objectForKey:@"VALUE"];
    list.title = [dict objectForKey:@"NAME"];
    [self.navigationController pushViewController:list animated:YES];
    [list release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"tab4.png"];
        self.title = NSLocalizedString(@"SL_Tab4_Title", );
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = Nav_Color;
    self.view.backgroundColor = Gray_Color;

    [self createTableView];

    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SL_Catalog_New", ) 
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self 
                                                                action:@selector(addAction:)];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
}

- (void)addAction:(id)sender
{
    FGTextFieldViewController *tx = [[FGTextFieldViewController alloc] init];
    tx.title = NSLocalizedString(@"SL_Catalog_New", );
    tx.promptTitle = tx.title;
    tx.delegate = self;
    [self.navigationController pushViewController:tx animated:YES];
    [tx release];
}

-(void)didInputTextField:(NSString *)text rootController:(UIViewController *)ctrl
{
    [[SLFileObject sharedInstance] addNewCatalog:text];
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
