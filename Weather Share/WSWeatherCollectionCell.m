//
//  WSWeatherCollectionCell.m
//  Weather Share
//
//  Created by Puneet Goyal on 30/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "WSWeatherCollectionCell.h"
#import "YQLFetch.h"

@implementation WSWeatherCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addLabelsForWoeid:(NSString *)woeid{
    for(UIView *view in self.subviews)
        [view removeFromSuperview];

    UIActivityIndicatorView *refreshIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [refreshIndicator startAnimating];
    [self addSubview:refreshIndicator];
    UILabel *placeName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    dispatch_queue_t downloadQueue = dispatch_queue_create("download queue", NULL);
    dispatch_async(downloadQueue, ^{
        NSString *name =[YQLFetch placeNameForWoeid:woeid];
        NSDictionary *currentForecast = [YQLFetch forecastForTodayForWoeid:woeid];
        dispatch_async(dispatch_get_main_queue(), ^{
            placeName.text = name;
            UILabel *low = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, 20)];
            low.text = [NSString stringWithFormat:@"Low: %@",[currentForecast objectForKey:@"low"]];
            UILabel *high = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, 20)];
            high.text = [NSString stringWithFormat:@"High: %@",[currentForecast objectForKey:@"high"]];
            [refreshIndicator removeFromSuperview];
            for(UIView *view in self.subviews)
                [view removeFromSuperview];
            [self addSubview:placeName];
            [self addSubview:low];
            [self addSubview:high];
        });
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
