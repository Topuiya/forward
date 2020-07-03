//
//  CalendarHeadView.m
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "CalendarHeadView.h"
#import <FSCalendar.h>

@interface CalendarHeadView () <FSCalendarDelegate,FSCalendarDataSource>
@property (weak, nonatomic) FSCalendar *calendar;

@end

@implementation CalendarHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"CalendarHeadView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}



@end
