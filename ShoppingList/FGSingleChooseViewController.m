    //
//  FGSingleChooseViewController.m
//  FreeGo
//
//  Created by navy on 11-11-5.
//  Copyright 2011 freelancer. All rights reserved.
//

#import "FGSingleChooseViewController.h"

@interface FGSingleChooseViewController()

- (void)createTableView;

@end

@implementation FGSingleChooseViewController

@synthesize dataArray,delegate;

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

- (void)createTableView
{
	if( tbView )
		return ;
	
	tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height ) style:UITableViewStyleGrouped];
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

- (id)initWithArray:(NSArray *)arr
{
	self = [super init];
	if (self) {
		self.dataArray = arr;
        checkedRow = -1;

	}
	return self;
}

- (void)loadWithIndex:(int)index
{
    checkedRow = index;
    [tbView reloadData];
}

- (id)init
{
	self = [super init];
	if (self) {
	}
	return self;
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.93 blue:0.91 alpha:1.0];
	[self createTableView];
}


#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 44;
}

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
	
	static NSString *Identifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
	if (checkedRow == indexPath.row) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}

	cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
	
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	checkedRow = indexPath.row;
	[tbView performSelector:@selector(reloadData) withObject:nil afterDelay:0.2];
	[self.navigationController popViewControllerAnimated:YES];
	if ([delegate respondsToSelector:@selector(didChooseString:rootController:)]) {
		[delegate didChooseString:[dataArray objectAtIndex:checkedRow] rootController:self];
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
}


- (void)dealloc {
	SL_RELEASE(dataArray);
	SL_RELEASE(tbView);
    [super dealloc];
}


@end
