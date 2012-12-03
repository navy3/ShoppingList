//
//  SLItemListViewController.m
//  ShoppingList
//
//  Created by  on 12-6-21.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLItemListViewController.h"
#import "SLItem.h"

@interface SLItemListViewController ()

@property (nonatomic, retain) UITableView *tbView;

@end

@implementation SLItemListViewController

@synthesize dataArray,tbView;

- (void)dealloc
{
    SL_RELEASE(dataArray);
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
    return [dataArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    NSDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:kNameKey];
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source.
		[dataArray removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}     
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    selectedIndex = indexPath.row;
    SLItemDetailViewController *tx = [[SLItemDetailViewController alloc] init];
    tx.title = NSLocalizedString(@"SL_Item", );
    NSDictionary *dict = [dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:tx animated:YES];
    SLItem *item = [[SLItem alloc] initWithDict:dict];
    tx.delegate = self;
    [tx setItem:item];
    [item release];
    [tx release];
}

- (void)addItem:(NSDictionary *)dict withRootCtrl:(UIViewController *)ctrl
{
    if ([ctrl.title isEqualToString:NSLocalizedString(@"SL_Item", )]) {
        [dataArray replaceObjectAtIndex:selectedIndex withObject:dict];
        [tbView reloadRowsAtIndexPaths:
         [NSArray arrayWithObject:[NSIndexPath indexPathForRow:selectedIndex inSection:0]] 
                      withRowAnimation:UITableViewRowAnimationFade];
    }
    else {
        [dataArray addObject:dict];
        [tbView reloadData];
    }
    [ctrl.navigationController popViewControllerAnimated:YES];
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
    self.view.backgroundColor = Gray_Color;
    [self createTableView];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SL_Item_New", ) 
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self 
                                                                action:@selector(addAction:)];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
}

- (void)addAction:(id)sender
{
    SLItemDetailViewController *tx = [[SLItemDetailViewController alloc] init];
    tx.title = NSLocalizedString(@"SL_Item_New", );
    [self.navigationController pushViewController:tx animated:YES];
    tx.delegate = self;
    [tx setItem:[[[SLItem alloc] init] autorelease]];
    [tx release];
}

-(void)didInputTextField:(NSString *)text rootController:(UIViewController *)ctrl
{
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
