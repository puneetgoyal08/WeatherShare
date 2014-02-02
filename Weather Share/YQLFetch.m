//
//  YQLFetch.m
//  Weather Share
//
//  Created by Puneet Goyal on 28/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "YQLFetch.h"

@implementation YQLFetch

+(int)getWoeid{
    
    return 0;
}

+ (NSDictionary *)executeFetchRequest:(NSString *)query
{
    query = [NSString stringWithFormat:@"http://query.yahooapis.com/v1/public/yql?q=%@&format=json&diagnostics=true&callback=", query];
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    // NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
    return results;
}

+ (NSArray *)getWoeidsForName:(NSString *)name
{
    NSString *query = [NSString stringWithFormat:@"select woeid from geo.places where text=\"%@\"",name];
    NSDictionary *woeids = [self executeFetchRequest:query];
    NSDictionary *query1 = [woeids objectForKey:@"query"];
    NSDictionary *results = [query1 objectForKey:@"results"];
    if(!results)
        return nil;
    NSArray *place = [results objectForKey:@"place"];
    NSMutableArray *woeidArray = [NSMutableArray array];
    for(NSDictionary *woeid in place){
        [woeidArray addObject:[woeid objectForKey:@"woeid"]];
    }
    return [woeidArray copy];
}

+ (NSDictionary *)getWeatherForecastForWoeid:(NSString *)woeid{
    NSString *query = [NSString stringWithFormat:@"select * from weather.forecast where woeid=%@", woeid];
    NSDictionary *queryDic = [self executeFetchRequest:query];
    NSDictionary *results = [[queryDic objectForKey:@"query"] objectForKey:@"results"];
    NSDictionary *channel = [results objectForKey:@"channel"];
    return channel;
}

+ (NSString *)placeNameForWoeid : (NSString *)woeid{
    NSString *query = [NSString stringWithFormat:@"select * from geo.places where woeid=%@", woeid];
    NSDictionary *queryDic = [self executeFetchRequest:query];
    NSDictionary *results = [[queryDic objectForKey:@"query"] objectForKey:@"results"];
    NSDictionary *place = [results objectForKey:@"place"];
    NSString *name = [place objectForKey:@"name"];
    NSDictionary *placeTypeName = [place objectForKey:@"placeTypeName"];
    NSString* placeTypeContent = [placeTypeName objectForKey:@"content"];
    if([placeTypeContent isEqualToString:@"Town"]||[placeTypeContent isEqualToString:@"City"]){
        NSString *countryName =[[place objectForKey:@"country"] objectForKey:@"content"];
        return [[name stringByAppendingString:@" ,"] stringByAppendingString:countryName];
    }
    return name;
}

+(float)getWindDirectionForChannel : (NSDictionary *)channel{
    NSString *windDirection = [channel objectForKey:@"wind.speed"];
    return [windDirection floatValue];
}

+ (NSDictionary *)forecastForTodayForWoeid:(NSString *)woeid{

    NSDictionary *item = [[self getWeatherForecastForWoeid:woeid] objectForKey:@"item"];
    NSArray *forecast = [item objectForKey:@"forecast"];
    
    return [forecast objectAtIndex:0];
}

@end
