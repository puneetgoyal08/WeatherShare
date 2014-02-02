//
//  WeatherViewController.h
//  Weather Share
//
//  Created by Puneet Goyal on 28/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic, strong) NSDictionary *channel;
@end
