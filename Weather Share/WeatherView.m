//
//  WeatherView.m
//  Weather Share
//
//  Created by Puneet Goyal on 28/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "WeatherView.h"

@interface WeatherView()

@property (nonatomic, strong) UILabel *low;
@property (nonatomic, strong) UILabel *high;
@property (nonatomic, strong) UILabel *condition;
@property (nonatomic, strong) UILabel *date;

@end

@implementation WeatherView
@synthesize weatherForecastDetails = _weatherForecastDetails;
@synthesize low = _low;
@synthesize high = _high;
@synthesize condition = _condition;
@synthesize date = _date;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    if(self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.date = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width-20, 20)];
    self.low = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, self.frame.size.width-20, 20)];
    self.high= [[UILabel alloc] initWithFrame:CGRectMake(20, 80, self.frame.size.width-20, 20)];
    self.condition = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, self.frame.size.width-20, 20)];
    [self addSubview:self.low];
    [self addSubview:self.high];
    [self addSubview:self.condition];
    [self addSubview:self.date];
}

- (void)setWeatherForecastDetails:(NSDictionary *)weatherForecastDetails
{
    _weatherForecastDetails = weatherForecastDetails;
    [self.low setText:[NSString stringWithFormat:@"Low: %@",[weatherForecastDetails objectForKey:@"low"]]];
    [self.high setText:[NSString stringWithFormat:@"High: %@",[weatherForecastDetails objectForKey:@"high"]]];
    [self.condition setText:[NSString stringWithFormat:@"Weather Condition : %@",[weatherForecastDetails objectForKey:@"text"]]];
    [self.date setText:[NSString stringWithFormat:@"Date: %@", [weatherForecastDetails objectForKey:@"date"]]];
}

@end
