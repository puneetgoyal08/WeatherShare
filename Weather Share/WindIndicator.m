//
//  WindIndicator.m
//  Weather Share
//
//  Created by Puneet Goyal on 29/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "WindIndicator.h"

@interface WindIndicator()

@property (nonatomic, strong) UIImageView *indicatorView;
@end

@implementation WindIndicator
@synthesize direction = _direction;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.indicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass2"]];
        
        // Initialization code
    }
    return self;
}

-(void)setDirection:(CGFloat)direction
{
    _direction = direction;
    [self rotate];
}

- (void)rotate
{
    self.indicatorView.transform = CGAffineTransformMakeRotation(self.direction);
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
