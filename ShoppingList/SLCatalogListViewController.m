//
//  SLCatalogListViewController.m
//  ShoppingList
//
//  Created by  on 12-6-22.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLCatalogListViewController.h"
#import "SLFileObject.h"

@interface SLCatalogListViewController ()

@property (nonatomic, retain) UITableView *tbView;
@property (nonatomic, retain) NSMutableArray *checkArray;

@end

@implementation SLCatalogListViewController

@synthesize tbView,checkArray,delegate;

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
    return [[[SLFileObject sharedInstance] catalogArray] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = [[[SLFileObject sharedInstance] catalogArray] objectAtIndex:section];
    return [dict objectForKey:kSLNameKey];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dict = [[[SLFileObject sharedInstance] catalogArray] objectAtIndex:section];
    NSArray *arr = [dict objectForKey:kSLValueKey];
    return [arr count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < [[[SLFileObject sharedInstance] catalogArray] count]; i++) {
        NSDictionary *dict = [[[SLFileObject sharedInstance] catalogArray] objectAtIndex:i];
        [arr addObject:[dict objectForKey:kSLNameKey]];
    }
    return arr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		//cell.editingStyle = UITableViewCellEditingStyleInsert;
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    NSDictionary *dict = [[[SLFileObject sharedInstance] catalogArray] objectAtIndex:indexPath.section];
    NSArray *arr = [dict objectForKey:kSLValueKey];
    NSDictionary *subDict = [arr objectAtIndex:indexPath.row];
    cell.textLabel.text = [subDict objectForKey:kNameKey];
    
    BOOL checkflag = NO;
//    for (int i = 0; i < [checkArray count]; i++) {
//        NSIndexPath *path = [checkArray objectAtIndex:i];
//        if (0 == [indexPath compare:path]) {
//            flag = YES;
//            break;
//        }
//    }
    
    for (int i = 0; i < [checkArray count]; i++) {
        NSMutableArray *arr = [checkArray objectAtIndex:i];
        for (NSIndexPath *path in arr) {
            if (0 == [indexPath compare:path]) {
                checkflag = YES;
                break;
            }
        }
    }
    
    if (checkflag) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    //NSMutableArray *arr = [checkArray objectAtIndex:indexPath.section];
        

//    BOOL flag = YES;
//    
//    for (int i = 0; i < [checkArray count]; i++) {
//        NSIndexPath *path = [checkArray objectAtIndex:i];
//        if (0 == [indexPath compare:path]) {
//            [checkArray removeObjectAtIndex:i];
//            flag = NO;
//            break;
//        }
//    }
//    
//    if (flag) {
//        [checkArray addObject:indexPath];
//    }

    BOOL addFlag = YES;
    
    for (int i = 0; i < [checkArray count]; i++) {
        NSMutableArray *arr = [checkArray objectAtIndex:i];
        for (int j = 0; j < [arr count]; j++) {
            NSIndexPath *path = [arr objectAtIndex:j];
            if (0 == [indexPath compare:path]) {
                [arr removeObjectAtIndex:j];
                addFlag = NO;
                break;
            }
        }
    }
    
    if (addFlag) {
        if (0 == [checkArray count]) {
            [checkArray addObject:[NSMutableArray arrayWithObject:indexPath]];
        }
        else {
            int addIndex = -1;
            for (int i = 0; i < [checkArray count]; i++) {
                NSMutableArray *arr = [checkArray objectAtIndex:i];
                for ( NSIndexPath *path in arr) {
                    if (indexPath.section == path.section) 
                    {
                        addIndex = i;
                        break;
                    }
                }
            }
            if (-1 == addIndex) {
                [checkArray addObject:[NSMutableArray arrayWithObject:indexPath]];
            }
            else {
                NSMutableArray *arr = [checkArray objectAtIndex:addIndex];
                [arr addObject:indexPath];
            }

        }

    }
    
    if (0 < [checkArray count]) {
        UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                  target:self
                                                                                  action:@selector(doneAction:)];
        self.navigationItem.rightBarButtonItem = rightBar;
        [rightBar release];
    }
    else {
        UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SL_Item_New", ) 
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self 
                                                                    action:@selector(addAction:)];
        self.navigationItem.rightBarButtonItem = rightBar;
        [rightBar release];
    }
    
    
    [tbView reloadData];
//    if ([@"0" isEqualToString:[arr objectAtIndex:indexPath.row]]) {
//        [arr replaceObjectAtIndex:indexPath.row withObject:@"1"];
//        [tbView reloadData];
//        return;
//    }
//    if ([@"1" isEqualToString:[arr objectAtIndex:indexPath.row]]) {
//        [arr replaceObjectAtIndex:indexPath.row withObject:@"0"];
//        [tbView reloadData];
//        return;
//    }
    
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
    self.navigationController.navigationBar.tintColor = Nav_Color;
    self.view.backgroundColor = [UIColor whiteColor];
    self.checkArray = [NSMutableArray arrayWithCapacity:0];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                              target:self
                                                                              action:@selector(cancelAction:)];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SL_Item_New", ) 
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self 
                                                                action:@selector(addAction:)];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
    
    [self createTableView];
}

- (void)cancelAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)addAction:(id)sender
{
    SLItemDetailViewController *detail = [[SLItemDetailViewController alloc] init];
    detail.title = NSLocalizedString(@"SL_Item_New", );
    [self.navigationController pushViewController:detail animated:YES];
    [detail showNumber];
    detail.delegate = self;
    [detail setItem:[[[SLItem alloc] init] autorelease]];
    [detail release];

}

- (void)addItem:(NSDictionary *)dict withRootCtrl:(UIViewController *)ctrl
{
    if ([delegate respondsToSelector:@selector(selectedItems:withRootCtrl:)]) {
        [delegate selectedItems:[NSMutableArray arrayWithObject:[NSMutableArray arrayWithObject:dict]] withRootCtrl:self];
    }
}

- (void)doneAction:(id)sender
{
    if ([delegate respondsToSelector:@selector(selectedItems:withRootCtrl:)]) {
        NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];

        for (int i = 0 ; i < [checkArray count]; i++) {
//            NSIndexPath *indexPath = [checkArray objectAtIndex:i];
//            NSDictionary *dict = [[[SLFileObject sharedInstance] catalogArray] objectAtIndex:indexPath.section];
//            NSArray *arr = [dict objectForKey:kSLValueKey];
//            NSDictionary *subDict = [arr objectAtIndex:indexPath.row];
//            [resultArray addObject:subDict];
            NSMutableArray *arr = [checkArray objectAtIndex:i];
            NSMutableArray *subArr = [[NSMutableArray alloc] initWithCapacity:0];
            
            for (int j = 0; j < [arr count]; j++) {
                NSIndexPath *indexPath = [arr objectAtIndex:j];
                NSDictionary *dict = [[[SLFileObject sharedInstance] catalogArray] objectAtIndex:indexPath.section];
                NSArray *arr = [dict objectForKey:kSLValueKey];
                NSDictionary *subDict = [arr objectAtIndex:indexPath.row];
                [subArr addObject:subDict];
            }
            [resultArray addObject:subArr];
            [arr release];
        }
        
        [delegate selectedItems:resultArray withRootCtrl:self];
    }
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
