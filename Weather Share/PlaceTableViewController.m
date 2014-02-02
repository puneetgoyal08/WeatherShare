//
//  PlaceTableViewController.m
//  Weather Share
//
//  Created by Puneet Goyal on 28/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "PlaceTableViewController.h"
#import "YQLFetch.h"
#import "WeatherViewController.h"
#import "WoeidListManager.h"

@interface PlaceTableViewController ()
@property (nonatomic, strong) NSArray *woeids;

@end

@implementation PlaceTableViewController
@synthesize woeids = _woeids;
@synthesize placeName = _placeName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setPlaceName:(NSString *)placeName
{
    _placeName = placeName;
    UIActivityIndicatorView *refreshIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [refreshIndicator startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:refreshIndicator];
    dispatch_queue_t downloadQueue = dispatch_queue_create("woeids download", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *woeids = [YQLFetch getWoeidsForName:self.placeName];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!woeids)
                NSLog(@"show an alert to enter some valid text");
            self.woeids = woeids;
            [[self tableView] reloadData];
            self.navigationItem.rightBarButtonItem = nil;
        });
    });
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.woeids.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = [YQLFetch placeNameForWoeid:[[self woeids] objectAtIndex:indexPath.row]];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherViewController *weatherVC = [[WeatherViewController alloc] init];
    NSString *woied = [[self woeids] objectAtIndex:indexPath.row];
    [weatherVC setChannel:[YQLFetch getWeatherForecastForWoeid:woied]];
    [[self navigationController] pushViewController:weatherVC animated:YES];
    [WoeidListManager insertWoeid:woied];
}

@end
