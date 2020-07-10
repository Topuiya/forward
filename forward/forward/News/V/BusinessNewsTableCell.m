//
//  BusinessNewsTableCell.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "BusinessNewsTableCell.h"

@interface BusinessNewsTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation BusinessNewsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setBusinessModel:(BusinessNewsModel *)businessModel {
    _businessModel = businessModel;
    
    self.contentLabel.text = businessModel.content;
    self.countryLabel.text = [NSString stringWithFormat:@"来自%@",businessModel.country];
    self.regionLabel.text = businessModel.region;
    //将timeString时间戳转为正常格式时间
    NSTimeInterval interval = businessModel.time / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM时dd分"];
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;
}

@end
