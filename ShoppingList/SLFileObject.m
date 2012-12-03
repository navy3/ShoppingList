//
//  SLFileObject.m
//  ShoppingList
//
//  Created by  on 12-6-20.
//  Copyright (c) 2012年 freelancer. All rights reserved.
//

#import "SLFileObject.h"


@interface SLFileObject()

- (void)initSystemPath;

@end

static SLFileObject *helper = nil;

@implementation SLFileObject

@synthesize quickArray,catalogArray,templateArray,listArray;

+ (SLFileObject *)sharedInstance
{
    if (!helper) {
        helper = [[[self class] alloc] init];
    }
    return helper;
}

- (id)init
{
    if (self = [super init]) {
        [self initSystemPath];
    }
    return self;
}

- (void)initSystemPath
{
	//create path
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	//初始化文件路径
	NSString *quickList = [path stringByAppendingPathComponent:@"quickList.plist"];
	if (![[NSFileManager defaultManager] fileExistsAtPath:quickList isDirectory:NO]) {		
		//[[NSFileManager defaultManager] createDirectoryAtPath:systemList withIntermediateDirectories:YES attributes:nil error:nil];
        self.quickArray = [NSMutableArray arrayWithCapacity:0];
	}
    else {
        self.quickArray = [NSMutableArray arrayWithContentsOfFile:quickList];
    }
    
    //初始化文件路径
	NSString *mylists = [path stringByAppendingPathComponent:@"mylists.plist"];
	if (![[NSFileManager defaultManager] fileExistsAtPath:mylists isDirectory:NO]) {		
		//[[NSFileManager defaultManager] createDirectoryAtPath:systemList withIntermediateDirectories:YES attributes:nil error:nil];
        self.listArray = [NSMutableArray arrayWithCapacity:0];
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shopTemp" ofType:@"plist"]];
        for (int i = 0; i < [arr count]; i++) {
            [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[arr objectAtIndex:i],kSLNameKey,@"0",kSLIconKey,
                                      [NSMutableArray arrayWithCapacity:0],kSLValueKey,nil]];
        }
        
        [pool release];
	}
    else {
        self.listArray = [NSMutableArray arrayWithContentsOfFile:mylists];
    }
    
    //初始化文件路径
	NSString *tempList = [path stringByAppendingPathComponent:@"templateList.plist"];
	if (![[NSFileManager defaultManager] fileExistsAtPath:tempList isDirectory:NO]) {		
		//[[NSFileManager defaultManager] createDirectoryAtPath:systemList withIntermediateDirectories:YES attributes:nil error:nil];
        self.templateArray = [NSMutableArray arrayWithCapacity:0];

        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shopTemp" ofType:@"plist"]];
        for (int i = 0; i < [arr count]; i++) {
            [templateArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[arr objectAtIndex:i],kSLNameKey,
                                      [NSMutableArray arrayWithCapacity:0],kSLValueKey,nil]];
        }
        
        [pool release];

	}
    else {
        self.templateArray = [NSMutableArray arrayWithContentsOfFile:tempList];
    }
    
    NSString *catalogList = [path stringByAppendingPathComponent:@"catalogList.plist"];
	if (![[NSFileManager defaultManager] fileExistsAtPath:catalogList isDirectory:NO]) {		
		//[[NSFileManager defaultManager] createDirectoryAtPath:systemList withIntermediateDirectories:YES attributes:nil error:nil];
        self.catalogArray = [NSMutableArray arrayWithCapacity:0];
        
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"template" ofType:@"plist"]];
        for (int i = 0; i < [arr count]; i++) {
            NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:0];
            
            NSArray *subArr = [[arr objectAtIndex:i] objectAtIndex:1];
            for (int j = 0; j < [subArr count]; j++) {
                SLItem *item = [[[SLItem alloc] init] autorelease];
                item.name = [subArr objectAtIndex:j];
                item.type = [[arr objectAtIndex:i] objectAtIndex:0];
                [mutArr addObject:[item itemDictionary]];
            }
            
            [catalogArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[arr objectAtIndex:i] objectAtIndex:0],kSLNameKey,
                                     mutArr,kSLValueKey,nil]];
        }
        [pool release];
	}
    else {
        self.catalogArray = [NSMutableArray arrayWithContentsOfFile:catalogList];
    }
}

- (void)addNewCatalog:(NSString *)title
{
    [catalogArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:title,kSLNameKey,
                             [NSMutableArray arrayWithCapacity:0],kSLValueKey,nil]];
}

- (void)addNewTemplate:(NSString *)title
{
    [templateArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:title,kSLNameKey,
                             [NSMutableArray arrayWithCapacity:0],kSLValueKey,nil]];
}

- (void)addNewList:(NSString *)title andIconIndex:(int)index
{
    [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:title,kSLNameKey,[NSString stringWithFormat:@"%d",index],kSLIconKey,[NSMutableArray arrayWithCapacity:0],kSLValueKey,nil]];
}

- (void)dealloc
{
    SL_RELEASE(listArray);
    SL_RELEASE(templateArray);
    SL_RELEASE(catalogArray);
    SL_RELEASE(quickArray);
    [super dealloc];
}

- (BOOL)saveList
{
    BOOL flag;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *quickList = [path stringByAppendingPathComponent:@"quickList.plist"];
    NSString *catalogList = [path stringByAppendingPathComponent:@"catalogList.plist"];
    NSString *tempList = [path stringByAppendingPathComponent:@"template.plist"];
    NSString *myLists = [path stringByAppendingPathComponent:@"mylists.plist"];

    if([quickArray writeToFile:quickList atomically:YES]&&[catalogArray writeToFile:catalogList atomically:YES]
       &&[templateArray writeToFile:tempList atomically:YES]&&[listArray writeToFile:myLists atomically:YES])
    {
        flag = YES;
    }
    else {
        flag = NO;
    }
    
    return flag;
}

@end
