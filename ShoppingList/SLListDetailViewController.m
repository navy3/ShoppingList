//
//  SLListDetailViewController.m
//  ShoppingList
//
//  Created by  on 12-6-23.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLListDetailViewController.h"
#import "SLFileObject.h"

@interface SLListDetailViewController ()

@property (nonatomic, retain) UITableView *tbView;
@property (nonatomic, assign) NSMutableArray *dataArray;
@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UILabel *priceLabel;

@end

@implementation SLListDetailViewController

@synthesize tbView,dataArray,numberLabel,priceLabel;

- (id)initWithArray:(NSMutableArray *)arr
{
    if (self = [super init]) {
        self.dataArray = arr;
    }
    return self;
}

- (void)createTableView
{
	if( tbView )
		return ;
	
	self.tbView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - 30 - AdViewFrame) style:UITableViewStylePlain] autorelease];
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
    SL_RELEASE(numberLabel);
    SL_RELEASE(priceLabel);
    SL_RELEASE(tbView);
    [super dealloc];
}

- (void)createTotalLabel
{
    if (numberLabel) 
        return;
    
    self.numberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 30 - 93, self.view.bounds.size.width/2, 30)] autorelease];
    numberLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    numberLabel.textAlignment = UITextAlignmentLeft;
    numberLabel.font = [UIFont boldSystemFontOfSize:17];
    numberLabel.backgroundColor = [UIColor lightGrayColor];
    numberLabel.textColor = [UIColor blackColor];
    [self.view addSubview:numberLabel];
    
    if (priceLabel) 
        return;
    self.priceLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height - 30 - 93, self.view.bounds.size.width/2, 30)] autorelease];
    priceLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    priceLabel.textAlignment = UITextAlignmentRight;
    priceLabel.font = [UIFont boldSystemFontOfSize:17];
    priceLabel.backgroundColor = [UIColor lightGrayColor];
    priceLabel.textColor = [UIColor blackColor];
    [self.view addSubview:priceLabel];
    
    UIButton *email = [UIButton buttonWithType:UIButtonTypeCustom];
    [email setImage:[UIImage imageNamed:@"email.png"] forState:UIControlStateNormal];
    [email addTarget:self action:@selector(emailAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:email];
    [email setFrame:CGRectMake(0, 0, 30, 30)];
    [email setCenter:CGPointMake(self.view.center.x, numberLabel.center.y)];
    
    [self updateLabel];
}

- (void)emailAction:(id)sender
{
    if ([MFMailComposeViewController canSendMail]) {
		MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
		picker.mailComposeDelegate = self;
		
		[picker setSubject:self.title];
		
		
		// Set up recipients
//		NSArray *toRecipients = [NSArray arrayWithObject:@"focusspeed@gmail.com"]; 
//		
//		[picker setToRecipients:toRecipients];
//		
        NSString *mailContent = @"";
        for (int i = 0 ; i < [dataArray count]; i++) {
            NSArray *sub = [dataArray objectAtIndex:i];
            for (int j = 0; j < [sub count]; j++) {
                NSDictionary *dict = [sub objectAtIndex:j];
                if (0 == [[dict objectForKey:kDoneKey] intValue]) {
                    mailContent = [mailContent stringByAppendingFormat:@"%@ : %@\n",[dict objectForKey:kNameKey],[dict objectForKey:kQuantityKey]];
                }
            }
        }
		[picker setMessageBody:mailContent isHTML:NO];
		// Fill out the email body text
		//	NSData *data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"html"]];
		//	NSString *emailBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		//	[picker setMessageBody:emailBody isHTML:YES];
		//	[emailBody release];
		//	[data release];
		[self presentModalViewController:picker animated:YES];
		[picker release];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	
	if(error) 
		NSLog(@"ERROR - mailComposeController: %@", [error localizedDescription]);
	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
		default:
			break;
	}
	[controller dismissModalViewControllerAnimated:YES];
}

- (void)updateLabel
{
    float doneCount = 0;
    float totalCount = 0;
    
    for (int i = 0; i < [dataArray count]; i++) {
        NSArray *sub = [dataArray objectAtIndex:i];
        for (int j = 0; j < [sub count]; j++) {
            NSDictionary *dict = [sub objectAtIndex:j];
            float price = [[dict objectForKey:kPriceKey] floatValue];
            int num = [[dict objectForKey:kQuantityKey] intValue];
            totalCount += price * num;
            if (1 == [[dict objectForKey:kDoneKey] intValue]) {
                doneCount += price * num;
            }
        }
    }
    
    numberLabel.text = [NSString stringWithFormat:@"%@: $%.2f",NSLocalizedString(@"SL_Done_Price", ),doneCount];
    priceLabel.text = [NSString stringWithFormat:@"%@: $%.2f",NSLocalizedString(@"SL_Total_Price", ),totalCount];
    
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSArray *arr = [dataArray objectAtIndex:section];
    NSDictionary *dict = [arr objectAtIndex:0];
    return [dict objectForKey:kTypeKey];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [dataArray objectAtIndex:section];
    return [arr count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    SLItemCell *cell = (SLItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[SLItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
		//cell.editingStyle = UITableViewCellEditingStyleInsert;
        cell.delegate = self;
        
    }
    
    NSArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    NSDictionary *dict = [arr objectAtIndex:indexPath.row];
    
    SLItem *item = [[[SLItem alloc] initWithDict:dict] autorelease];
    [cell updateCell:item withIndex:indexPath];
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source.
		NSMutableArray *arr = [dataArray objectAtIndex:indexPath.section];
        [arr removeObjectAtIndex:indexPath.row];
        
        if (0 == [arr count]) {
            [dataArray removeObjectAtIndex:indexPath.section];
            [tableView reloadData];
        }
        else {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        [self updateLabel];

	}     
}

- (void)updateDict:(NSDictionary *)dict withIndex:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = [dataArray objectAtIndex:indexPath.section];
    [arr replaceObjectAtIndex:indexPath.row withObject:dict];
    [self updateLabel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
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
    self.view.backgroundColor = Gray_Color;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																			  target:self
																			  action:@selector(addAction:)];
	self.navigationItem.rightBarButtonItem = rightBar;
	[rightBar release];
    
    [self createTableView];
    [self createTotalLabel];
}

- (void)addAction:(id)sender
{
    SLCatalogListViewController *list = [[SLCatalogListViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:list];
    list.delegate = self;
    [self presentModalViewController:nc animated:YES];
    [list release];
    [nc release];

//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"SL_ActionSheet_AddList", ) 
//                                                       delegate:self 
//                                              cancelButtonTitle:NSLocalizedString(@"SL_ActionSheet_Cancel", ) 
//                                         destructiveButtonTitle:nil
//                                              otherButtonTitles:NSLocalizedString(@"SL_ActionSheet_TempList", ),NSLocalizedString(@"SL_ActionSheet_NewList", ), nil];
//    [sheet showInView:self.view.window];
//    [sheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{    
    if (0 == buttonIndex) {
        
    }
    else if (1 == buttonIndex) {
        SLCatalogListViewController *list = [[SLCatalogListViewController alloc] init];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:list];
        list.delegate = self;
        [self presentModalViewController:nc animated:YES];
        [list release];
        [nc release];
    }
}

- (void)selectedItems:(NSMutableArray *)arr withRootCtrl:(UIViewController *)ctrl
{
    for (int i = 0; i < [dataArray count] ; i++) {
        NSMutableArray *arr1 = [dataArray objectAtIndex:i];
        NSDictionary *dict1 = [arr1 objectAtIndex:0];
        for (int j = 0; j<[arr count]; j++) {
            NSMutableArray *arr2 = [arr objectAtIndex:j];
            NSDictionary *dict2 = [arr2 objectAtIndex:0];
            if ([[dict1 objectForKey:kTypeKey] isEqualToString:[dict2 objectForKey:kTypeKey]]) {
                [arr1 addObjectsFromArray:arr2];
                [arr removeObjectAtIndex:j];
            }
        }
    }
    
    if (0 < [arr count]) {
        [dataArray addObjectsFromArray:arr];
    }
    
    [self updateLabel];

    [tbView reloadData];
    [ctrl dismissModalViewControllerAnimated:YES];
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
