//
//  DetailTableCell.m
//  forward
//
//  Created by apple on 2020/7/17.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "DetailTableCell.h"

@interface DetailTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation DetailTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCommentModel:(CommentModel *)commentModel {
    _commentModel = commentModel;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.user.head] placeholderImage:[UIImage imageNamed:@"denglutouxiang"]];
    self.nameLabel.text = commentModel.user.nickName;
    self.timeLabel.text = [self timeToNSDate:commentModel.publishTime];
    self.contentLabel.text = commentModel.content;
}
- (NSString *)timeToNSDate:(double)time {
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSDateFormatter *dateFormatter = NSDateFormatter.new;
    [dateFormatter setDateFormat:@"MM-dd前"];
    NSString *dateStr = [dateFormatter stringFromDate:publishDate];
    return dateStr;
}
@end
