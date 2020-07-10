//
//  DIYCalendarCell.h
//  FSCalendar
//
//  Created by dingwenchao on 02/11/2016.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import <FSCalendar/FSCalendar.h>

@interface DIYCalendarCell : FSCalendarCell

@property (weak, nonatomic) UIImageView *circleImageView;

@property (nonatomic, strong) NSDate *ownDate;

@property (nonatomic, assign)BOOL hasChecked;

@end
