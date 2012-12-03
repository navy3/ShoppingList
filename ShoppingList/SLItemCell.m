//
//  SLItemCell.m
//  ShoppingList
//
//  Created by  on 12-6-21.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLItemCell.h"

@interface SLItemCell() 

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UIButton *checkBtn;
@property (nonatomic, retain) SLItem *item;
@property (nonatomic, retain) NSIndexPath *index;

@end

@implementation SLItemCell

@synthesize nameLabel,numberLabel,checkBtn,item,delegate,index;

- (void)dealloc
{
    CF_RELEASE(delegate);
    SL_RELEASE(nameLabel);
    SL_RELEASE(numberLabel);
    SL_RELEASE(checkBtn);
    SL_RELEASE(item);
    SL_RELEASE(index);
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self buildUI];
    }
    return self;
}

- (void)updateCell:(SLItem *)slitem withIndex:(NSIndexPath *)i
{
    self.index = i;
    self.item = slitem;
    nameLabel.text = item.name;
    int num = [item.quantity intValue];
    float price = [item.price floatValue] * num;
    if (1 == [item.isDone intValue]) {
        nameLabel.font = [UIFont italicSystemFontOfSize:17];
        nameLabel.textColor = [UIColor lightGrayColor];
        [checkBtn setSelected:YES];
    }
    else {
        nameLabel.font = [UIFont boldSystemFontOfSize:17];
        nameLabel.textColor = [UIColor darkGrayColor];
        [checkBtn setSelected:NO];
    }
    numberLabel.text = [NSString stringWithFormat:@"%d | $%.2f",num,price];
    
}

- (void)buildUI
{
    if (!nameLabel) {
		nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.width/2, 20)];
		nameLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		nameLabel.textAlignment = UITextAlignmentLeft;
		nameLabel.font = [UIFont boldSystemFontOfSize:17];
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.textColor = [UIColor darkGrayColor];
		nameLabel.highlightedTextColor = [UIColor whiteColor];
		[self.contentView addSubview:nameLabel];
	}
    
    if (!numberLabel) {
		numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, self.bounds.size.width/2, 14)];
		numberLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		numberLabel.textAlignment = UITextAlignmentLeft;
		numberLabel.font = [UIFont boldSystemFontOfSize:12];
		numberLabel.backgroundColor = [UIColor clearColor];
		numberLabel.textColor = [UIColor grayColor];
		numberLabel.highlightedTextColor = [UIColor whiteColor];
		[self.contentView addSubview:numberLabel];
	}
    
    if (!checkBtn) {
		self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[checkBtn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
		[checkBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
		[checkBtn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateHighlighted];
		[checkBtn setFrame:CGRectMake(self.bounds.size.width - 50, 0, 44, 44)];
		[checkBtn addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:checkBtn];
		
	}
}

- (void)checkAction:(id)sender
{
    [checkBtn setSelected:![checkBtn isSelected]];
    if ([checkBtn isSelected]) {
        nameLabel.font = [UIFont italicSystemFontOfSize:17];
        nameLabel.textColor = [UIColor lightGrayColor];
        item.isDone = @"1";
    }
    else {
        nameLabel.font = [UIFont boldSystemFontOfSize:17];
        nameLabel.textColor = [UIColor darkGrayColor];
        item.isDone = @"0";
    }
        
    if ([delegate respondsToSelector:@selector(updateDict:withIndex:)]) {
        [delegate updateDict:[item itemDictionary] withIndex:index];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
