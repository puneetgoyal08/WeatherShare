//
//  WindIndicatorImageView.m
//  Weather Share
//
//  Created by Puneet Goyal on 29/01/14.
//  Copyright (c) 2014 Puneet Goyal. All rights reserved.
//

#import "WindIndicatorImageView.h"

@implementation WindIndicatorImageView
@synthesize direction = _direction;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"compass2"];
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
        
        [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-64-37)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.image = newImage;
        self.contentMode = UIViewContentModeScaleAspectFit;
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
    self.transform = CGAffineTransformMakeRotation(self.direction);
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
