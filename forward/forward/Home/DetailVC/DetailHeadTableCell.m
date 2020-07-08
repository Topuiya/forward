//
//  DetailHeadTableCell.m
//  forward
//
//  Created by apple on 2020/7/8.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "DetailHeadTableCell.h"

@interface DetailHeadTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@end

@implementation DetailHeadTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNewsModel:(HomeNewsModel *)newsModel {
    _newsModel = newsModel;
    
    NSURL *picURL = [NSURL URLWithString:newsModel.picture];
    [self.picImageView sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"pic_remenzixun1"]];
    //截取掉第一个句号之前的字符串,拿到的是一个数组,取第一个
    self.titleLabel.text = [newsModel.content componentsSeparatedByString:@"。"][0];
    
    NSTimeInterval interval = newsModel.publishTime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;
    
    self.contentLabel.text = newsModel.content;
    
}

@end
