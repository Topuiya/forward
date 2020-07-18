//
//  CalendarTableViewCell.m
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "CalendarTableViewCell.h"

@interface CalendarTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *LeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@end

@implementation CalendarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // 发布按钮设置
    self.showBtn.layer.borderColor = [[UIColor colorWithHexString:@"#666666"] CGColor];
}

- (void)setCalendarModel:(QuoteCalendarModel *)calendarModel {
    _calendarModel = calendarModel;
       
    self.titleLabel.text = calendarModel.name;
    
    NSString *timeString = calendarModel.time.description;
    //将timeString时间戳转为正常格式时间
    NSTimeInterval interval = [timeString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM:dd"];
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;

    self.LeftLabel.text = calendarModel.previous;
    self.centerLabel.text = calendarModel.consensus;
    self.rightLabel.text = calendarModel.affect;
    if (calendarModel.affect != nil) {
        [self.showBtn setTitle:@"已公布" forState:UIControlStateNormal];
        self.showBtn.layer.borderColor = [[UIColor colorWithHexString:@"#E96E69"] CGColor];
        [self.showBtn setTitleColor:[UIColor colorWithHexString:@"#EA4F51"] forState:UIControlStateNormal];
    }
    
    if (calendarModel.star.intValue == 1)
        _star1.image = [UIImage imageNamed:@"starselected"];
    else if (calendarModel.star.intValue == 2)
        _star1.image = _star2.image = [UIImage imageNamed:@"starselected"];
    else if (calendarModel.star.intValue == 3)
        _star1.image = _star2.image = _star3.image = [UIImage imageNamed:@"starselected"];
    else if (calendarModel.star.intValue == 4)
        _star1.image = _star2.image = _star3.image = _star4.image = [UIImage imageNamed:@"starselected"];
    else
        _star1.image = _star2.image = _star3.image = _star4.image = _star5.image = [UIImage imageNamed:@"starselected"];
}

@end
