//
//  MainActivityViewController.m
//  Weather Share
//
//  Created by Puneet Goyal on 28/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "MainActivityViewController.h"
#import "YQLFetch.h"
#import "PlaceTableViewController.h"
#import "WoeidListManager.h"
#import "WeatherViewController.h"

@interface MainActivityViewController ()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic, strong) UIButton *submit;

@end

@implementation MainActivityViewController
@synthesize textField = _textField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self addPlaceTextField];
        [self addSubmitButton];
    }
    return self;
}

- (void)addPlaceTextField{
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/2,self.view.frame.size.width/2,40)];
    self.textField.backgroundColor = [UIColor cyanColor];
    self.textField.textColor = [UIColor lightGrayColor];
    self.textField.text = @"enter place";
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
}

- (IBAction)submitClicked:(id)sender{
    if(self.textField.text!=nil){
        NSLog(@"%@", self.textField.text);
        PlaceTableViewController *placeTVC = [[PlaceTableViewController alloc] init];
        [placeTVC setPlaceName:self.textField.text];
        [[self navigationController] pushViewController:placeTVC animated:YES];
    }
}

- (void)addSubmitButton{
    self.submit = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submit.frame =CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*3/4, self.view.frame.size.width/2, 40);
    self.submit.backgroundColor = [UIColor greenColor];
    [self.submit setTitle:@"Submit" forState:UIControlStateNormal];
    [[self submit] addTarget:self action:@selector(submitClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField.text length])
    {
        [textField resignFirstResponder];
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.textColor == [UIColor lightGrayColor]){
        textField.text = @"";
        textField.textColor = [UIColor blackColor];
    }
    return YES;
}

@end
