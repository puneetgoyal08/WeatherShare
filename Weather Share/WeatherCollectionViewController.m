//
//  WeatherCollectionViewController.m
//  Weather Share
//
//  Created by Puneet Goyal on 30/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "WeatherCollectionViewController.h"
#import "WeatherViewController.h"
#import "YQLFetch.h"
#import "WoeidListManager.h"
#import "WSWeatherCollectionCell.h"

@implementation WeatherCollectionViewController
@synthesize woeids = _woeids;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.woeids = [WoeidListManager getWoeids];
    [self.collectionView registerClass:[WSWeatherCollectionCell class] forCellWithReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collectionVIew

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = self.woeids.count;
    return count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WSWeatherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blueSky.jpg"]];
    [cell addLabelsForWoeid:[[self woeids] objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherViewController *weatherVC = [[WeatherViewController alloc] init];
    [weatherVC setChannel:[YQLFetch getWeatherForecastForWoeid:[self.woeids objectAtIndex:indexPath.row]]];
    [[self navigationController] pushViewController:weatherVC animated:YES];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender {
    if ([sender numberOfTouches] != 2)
        return;
    // Get the pinch points.
    CGPoint p1 = [sender locationOfTouch:0 inView:[self collectionView]];
    CGPoint p2 = [sender locationOfTouch:1 inView:[self collectionView]];
    // Compute the new spread distance.
    CGFloat xd = p1.x - p2.x;
    CGFloat yd = p1.y - p2.y;
    CGFloat distance = sqrt(xd*xd + yd*yd);
    // Update the custom layout parameter and invalidate.
    UICollectionViewFlowLayout* myLayout = (UICollectionViewFlowLayout*)[[self collectionView]
                                                 collectionViewLayout];
//    [myLayout updateSpreadDistance:distance];
//    [myLayout invalidateLayout];
}

@end
