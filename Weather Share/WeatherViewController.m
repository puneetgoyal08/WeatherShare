//
//  WeatherViewController.m
//  Weather Share
//
//  Created by Puneet Goyal on 28/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "WeatherViewController.h"
#import "YQLFetch.h"
#import "WeatherView.h"
#import "MainActivityViewController.h"
#import "WindIndicatorImageView.h"
#import "WeatherCollectionViewController.h"
#import "WoeidListManager.h"

@interface WeatherViewController ()

@property UILabel *weatherCondition;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic) int numberOfViews;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *forecasts;
@property (nonatomic, strong) UIBarButtonItem *rightBarButton;
@end

@implementation WeatherViewController
@synthesize weatherCondition = _weatherCondition;
@synthesize channel = _channel;
@synthesize numberOfViews = _numberOfViews;
@synthesize pageControl = _pageControl;
@synthesize rightBarButton = _rightBarButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setChannel:(NSDictionary *)channel
{
    _channel= channel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(!self.channel)
        self.channel = [YQLFetch getWeatherForecastForWoeid:[[WoeidListManager getWoeids] lastObject]];
    [self.view setBackgroundColor:[UIColor blueColor]];
    [self setupScrollView];
    [self pupulateForecast];
    [self setupPageControl];
    [self setupRightBarButton];
}

- (void)setupScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-37)];
    [self.scrollView setBackgroundColor:[UIColor redColor]];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.zoomScale=1;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = self.scrollView.frame.size;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
}

- (void)pupulateForecast
{
    for (UIView *eachView in self.scrollView.subviews)
        [eachView removeFromSuperview];
    CGFloat width = self.view.frame.size.width;
    self.forecasts = [[self.channel objectForKey:@"item"] objectForKey:@"forecast"];
    int i=0;
    for(NSDictionary *forecast in self.forecasts){
        self.scrollView.contentSize = CGSizeMake(width*(i+1), 0);
        
        //setup Weather View
        WeatherView *wv = [[WeatherView alloc] initWithFrame:self.scrollView.frame];
        UIImage *image = [UIImage imageNamed:@"compass2"];
//        UIImage *newImage = [self rotateImage:image onDegrees:180];
        UIImage *newImage = [self rotateImage:image onDegrees:[YQLFetch getWindDirectionForChannel:self.channel]];
        
        [wv setBackgroundColor:[UIColor colorWithPatternImage:newImage]];
        [wv setWeatherForecastDetails:[[[self.channel objectForKey:@"item"] objectForKey:@"forecast"] objectAtIndex:i]];
        [wv setFrame:CGRectMake(width*i, 0, width, self.scrollView.frame.size.height)];
        [self.scrollView addSubview:wv];
        i++;
    }
}

- (void)setupPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-37, self.view.frame.size.width, 37)];
    [self.pageControl setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0 alpha:0.4]];
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = [[self forecasts] count];
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
}

- (void)setupRightBarButton
{
    self.rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonClicked:)];
    UIBarButtonItem *collectionButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"grid_view"] style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonClicked:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:collectionButton,self.rightBarButton, nil];
}

- (IBAction)rightBarButtonClicked:(id)sender
{
    MainActivityViewController *mvc = [[MainActivityViewController alloc] init];
    [[self navigationController] pushViewController:mvc animated:YES];
}

- (IBAction) leftBarButtonClicked:(id)sender
{
    WeatherCollectionViewController *weatherCollectionVC = [[WeatherCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [[self navigationController] pushViewController:weatherCollectionVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = self.scrollView.contentOffset;
    int width = self.scrollView.frame.size.width;
    int index = offset.x/width;
    self.pageControl.currentPage = index;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.forecasts.count;
}

- (IBAction)changePage:(id)sender{
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width*self.pageControl.currentPage, 0)];
}

- (UIImage *)rotateImage:(UIImage *)image onDegrees:(float)degrees
{
    CGFloat rads = M_PI * degrees / 180;
    float newSize = self.view.frame.size.width;
    CGSize size =  CGSizeMake(newSize, newSize);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, newSize/2, newSize/2);
    CGContextRotateCTM(ctx, rads);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(-[image size].width/2,-[image size].height/2,[image size].width, [image size].height),image.CGImage);
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}


@end
