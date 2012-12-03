//
//  SLListsViewController.m
//  ShoppingList
//
//  Created by  on 12-6-19.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLListsViewController.h"
#import "SLFileObject.h"
#import "SLHelper.h"
#import "SLListDetailViewController.h"

@interface SLListsViewController ()

@property (nonatomic, retain) UITableView *tbView;

@end

@implementation SLListsViewController

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.image = [UIImage imageNamed:@"tab2.png"];
        self.title = NSLocalizedString(@"SL_Tab2_Title", );
    }
    return self;
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[SLFileObject sharedInstance] listArray] count];
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
    
    NSDictionary *dict = [[[SLFileObject sharedInstance] listArray] objectAtIndex:indexPath.row];
    
    cell.imageView.image = [SLHelper imageWithIndex:[[dict objectForKey:kSLIconKey] intValue]];

    cell.textLabel.text = [dict objectForKey:kSLNameKey];
    
    NSArray *arr = [dict objectForKey:kSLValueKey];
    if (0 == [arr count]) {
        //cell.detailTextLabel.text = NSLocalizedString(@"SL_No_Item", );
    }
    else {
        int count = 0;
        
        for (int i = 0; i < [arr count]; i++) {
            NSArray *sub = [arr objectAtIndex:i];
            count += [sub count];
        }
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",count];
    }
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source.
		[[[SLFileObject sharedInstance] listArray] removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}     
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSDictionary *dict = [[[SLFileObject sharedInstance] listArray] objectAtIndex:indexPath.row];
    SLListDetailViewController *detail = [[SLListDetailViewController alloc] initWithArray:[dict objectForKey:kSLValueKey]];
    [self.navigationController pushViewController:detail animated:YES];
    detail.title = [dict objectForKey:kSLNameKey];
    [detail release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = Nav_Color;
    self.view.backgroundColor = Gray_Color;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SL_Lists_New", ) 
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self 
                                                                action:@selector(addAction:)];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
    
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tbView reloadData];
}

- (void)addAction:(id)sender
{
    FGTextFieldViewController *tx = [[FGTextFieldViewController alloc] init];
    tx.title = NSLocalizedString(@"SL_Lists_New", );
    tx.promptTitle = tx.title;
    tx.delegate = self;
    [self.navigationController pushViewController:tx animated:YES];
    [tx showSegment];
    [tx release];
}

-(void)didInputTextField:(NSString *)text andIcon:(int)index rootController:(UIViewController *)ctrl
{
    [[SLFileObject sharedInstance] addNewList:text andIconIndex:index];
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
