//
//  WoeidListManager.h
//  Weather Share
//
//  Created by Puneet Goyal on 29/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WoeidListManager : NSObject

+ (NSArray *)getWoeids;
+ (void)insertWoeid :(NSString *)woeid;

@end
