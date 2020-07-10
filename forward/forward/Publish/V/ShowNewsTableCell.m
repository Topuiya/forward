//
//  ShowNewsTableCell.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "ShowNewsTableCell.h"

@interface ShowNewsTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ShowNewsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setNewsModel:(HomeNewsModel *)newsModel {
    _newsModel = newsModel;
    //大图
    NSURL *picURL = [NSURL URLWithString:newsModel.picture];
    [self.picImgView sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"pic_remenzixun1"]];
    //标题:截取掉第一个句号之前的字符串,拿到的是一个数组,取第一个
    self.contentLabel.text = [newsModel.content componentsSeparatedByString:@"。"][0];
    //时间
    NSTimeInterval interval = newsModel.publishTime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    self.timeLabel.text = dateString;\
    //头像
    NSURL *headURL = [NSURL URLWithString:newsModel.user.head];
    [self.headImgView sd_setImageWithURL:headURL placeholderImage:[UIImage imageNamed:@"denglutouxiang"]];
    //昵称
    self.nameLabel.text = newsModel.user.nickName;
    
    
}

@end
