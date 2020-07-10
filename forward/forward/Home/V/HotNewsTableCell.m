//
//  HotNewsTableCell.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "HotNewsTableCell.h"

@interface HotNewsTableCell ()

//@"content",
//NSStringFromSelector(@selector(publishTime)):@"publishTime",
//NSStringFromSelector(@selector(picture)):@"picture",
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;


@end

@implementation HotNewsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNewsModel:(HomeNewsModel *)newsModel {
    _newsModel = newsModel;
    
    NSURL *picURL = [NSURL URLWithString:newsModel.picture];
    [self.picImageView sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"pic_remenzixun1"]];
    //截取掉第一个句号之前的字符串,拿到的是一个数组,取第一个
    self.contentLabel.text = [newsModel.content componentsSeparatedByString:@"。"][0];
    
    NSTimeInterval interval = newsModel.publishTime / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"aahh:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    self.publishTime.text = dateString;
    self.projectLabel.text = newsModel.user.projectKey;
}

@end
