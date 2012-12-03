//
//  SLItem.m
//  ShoppingList
//
//  Created by  on 12-6-21.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLItem.h"

@implementation SLItem

@synthesize name,aisle,quantity,unit,price,tax,note,isDone,type;

- (void)dealloc
{
    SL_RELEASE(name);
    SL_RELEASE(aisle);
    SL_RELEASE(quantity);
    SL_RELEASE(unit);
    SL_RELEASE(price);
    SL_RELEASE(tax);
    SL_RELEASE(note);
    SL_RELEASE(isDone);
    SL_RELEASE(type);
    [super dealloc];
}

- (id)init
{
    if (self = [super init]) {
        self.name = @"";
        self.aisle = @"";
        self.quantity = @"1";
        self.unit = @"";
        self.price = @"";
        self.tax = @"";
        self.note = @"";
        self.isDone = @"0";
        self.type = NSLocalizedString(@"SN_Item_None", );
    }
    return self;
}

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = [dict objectForKey:kNameKey];
        self.aisle = [dict objectForKey:kAisleKey];
        self.quantity = [dict objectForKey:kQuantityKey];
        self.unit = [dict objectForKey:kUnitKey];
        self.price = [dict objectForKey:kPriceKey];
        self.tax = [dict objectForKey:kTaxKey];
        self.note = [dict objectForKey:kNoteKey];
        self.isDone = [dict objectForKey:kDoneKey];
        self.type = [dict objectForKey:kTypeKey];
    }
    return self;
}

- (NSDictionary *)itemDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:name,kNameKey,aisle,kAisleKey,quantity,kQuantityKey,unit,kUnitKey,price,kPriceKey,tax,kTaxKey,note,kNoteKey,isDone,kDoneKey,type,kTypeKey, nil];
}
@end
