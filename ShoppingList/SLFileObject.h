//
//  SLFileObject.h
//  ShoppingList
//
//  Created by  on 12-6-20.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLItem.h"

#define kSLNameKey @"NAME"
#define kSLValueKey @"VALUE"
#define kSLIconKey @"ICON"

@interface SLFileObject : NSObject
{
    NSMutableArray *quickArray;
    NSMutableArray *catalogArray;
    NSMutableArray *templateArray;
    NSMutableArray *listArray;
}
@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, retain) NSMutableArray *templateArray;
@property (nonatomic, retain) NSMutableArray *catalogArray;
@property (nonatomic, retain) NSMutableArray *quickArray;

+ (SLFileObject *)sharedInstance;

- (void)initSystemPath;

- (BOOL)saveList;

- (void)addNewCatalog:(NSString *)title;
- (void)addNewTemplate:(NSString *)title;
- (void)addNewList:(NSString *)title andIconIndex:(int)index;

@end
