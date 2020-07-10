//
//  TimeNewsDetailTableCell.m
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "TimeNewsDetailTableCell.h"

@interface TimeNewsDetailTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TimeNewsDetailTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTimeNewsModel:(TimeNewsModel *)timeNewsModel {
    _timeNewsModel = timeNewsModel;
    
    //将timeString时间戳转为正常格式时间
    NSTimeInterval interval = [timeNewsModel.time doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM:dd:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;
    
    self.contentLabel.text = timeNewsModel.content;
    
}

@end
