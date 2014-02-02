//
//  YQLFetch.h
//  Weather Share
//
//  Created by Puneet Goyal on 28/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQLFetch : NSObject

+ (NSArray *)getWoeidsForName:(NSString *)name;
+ (NSString *)placeNameForWoeid : (NSString *)woeid;
+ (NSDictionary *)getWeatherForecastForWoeid:(NSString *)woeid;
+ (float)getWindDirectionForChannel : (NSDictionary *)channel;
+ (NSDictionary *)forecastForTodayForWoeid:(NSString *)woeid;

@end
