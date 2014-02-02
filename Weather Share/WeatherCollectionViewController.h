//
//  WeatherCollectionViewController.h
//  Weather Share
//
//  Created by Puneet Goyal on 30/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCollectionViewController : UICollectionViewController<UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *woeids;

@end
