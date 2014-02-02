//
//  WoeidListManager.m
//  Weather Share
//
//  Created by Puneet Goyal on 29/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "WoeidListManager.h"

@implementation WoeidListManager

+ (NSString *)rootPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)plistPath
{
    return [[self rootPath] stringByAppendingString:@"Data.plist"];
}

+ (void)openDocument
{
}

+ (NSArray *)getWoeids
{
    return [[self currentDictionary] objectForKey:@"woeids"];
}

+ (NSDictionary *)currentDictionary
{
    NSPropertyListFormat format;
    NSString *errorDesc = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format errorDescription:&errorDesc];
    return temp;
}

+ (void)insertWoeid: (NSString *)woeid
{
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
    NSMutableArray *marray = [[NSMutableArray alloc] initWithArray:[self getWoeids]];
    [marray addObject:woeid];
    
    NSDictionary *plistDict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:marray] forKeys:[NSArray arrayWithObject:@"woeids"]];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
}
@end
