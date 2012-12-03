//
//  SLItem.h
//  ShoppingList
//
//  Created by  on 12-6-21.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNameKey @"kNameKey"
#define kAisleKey @"kAisleKey"
#define kQuantityKey @"kQuantityKey"
#define kUnitKey @"kUnitKey"
#define kPriceKey @"kPriceKey"
#define kTaxKey @"kTaxKey"
#define kNoteKey @"kNoteKey"
#define kDoneKey @"kDoneKey"
#define kTypeKey @"kTypeKey"

@interface SLItem : NSObject
{
    NSString *name;
    NSString *aisle;
    NSString *quantity;
    NSString *unit;
    NSString *price;
    NSString *tax;
    NSString *note;
    NSString *type;
    //1 Done; 0 Undone.
    NSString *isDone;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *aisle;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *tax;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *isDone;
@property (nonatomic, copy) NSString *type;

- (NSDictionary *)itemDictionary;
- (id)initWithDict:(NSDictionary *)dict;

@end
