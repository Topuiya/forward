//
//  DIYCalendarCell.m
//  FSCalendar
//
//  Created by dingwenchao on 02/11/2016.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import "DIYCalendarCell.h"
#import "FSCalendarExtensions.h"

@implementation DIYCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qiandaoxianshi"]];
        
        CGRect circleFrame = CGRectMake(15, 8.5, 24, 24);
        
        //8(SE2)
        if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667)
        {
            circleFrame = CGRectMake(15, 8.5, 24, 24);
        }
        //11 Pro
        else if(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812)
        {
            circleFrame = CGRectMake(15, 8.5, 24, 24);
        }
        //8 Plus
        else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736)
        {
            circleFrame = CGRectMake(17.5, 11, 24, 24);
        }
        //11 Pro Max
        else if (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896)
        {
            circleFrame = CGRectMake(17.5, 11, 24, 24);
        }
        
        circleImageView.frame = circleFrame;
        _circleImageView = circleImageView;
        
        [self.contentView addSubview:_circleImageView];
        [self.contentView bringSubviewToFront:_circleImageView];
        
        _circleImageView.hidden = YES;
    }
    return self;
}

-(void)setHasChecked:(BOOL)hasChecked
{
    _hasChecked = hasChecked;
    if(_hasChecked)
    {
        _circleImageView.hidden = NO;
        self.shapeLayer.hidden = YES;
    }
    else
    {
        _circleImageView.hidden = YES;
        self.shapeLayer.hidden = NO;
    }
}

@end
