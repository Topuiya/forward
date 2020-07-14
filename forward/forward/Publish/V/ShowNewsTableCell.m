//
//  ShowNewsTableCell.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "ShowNewsTableCell.h"
#import "UserModel.h"

@interface ShowNewsTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *log;
@property (nonatomic, assign) bool hasFollow;
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
    
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSNumber *hasLog = [EGHCodeTool getOBJCWithSavekey:isLog];
    self.userId = user.userId;
    self.log = hasLog;
    if ([_log  isEqual: @1]) {
        [self followUser];
    }
}
- (void)followUser {
    //判断用户是否登录
    if ([_log  isEqual: @1]) {
        //用户登录之后判断是否关注过该用户
        [self whetherFollow:self.newsModel.user.userId];
    }
}
- (IBAction)attentionBtnClick:(id)sender {
    if ([_log  isEqual: @1]) {
        if (self.hasFollow == NO) {
            [self didFollow:_newsModel.user.userId];
        }
        else if (self.hasFollow == YES){
            [self removeFollow:_newsModel.user.userId];
        }
        self.attentionBtn.selected = self.hasFollow;
    }
}

//MARK:API
//是否关注用户
- (void)whetherFollow:(NSNumber *)followerId {
    WEAKSELF
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSDictionary *dic = @{@"userId":user.userId,
                          @"followerId":followerId};
    [ENDNetWorkManager getWithPathUrl:@"/user/follow/isFollow" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSNumber *resultNum = result[@"data"];
        if([resultNum isEqualToNumber:@0])
        {
            weakSelf.hasFollow = NO;
        }
        else if([resultNum isEqualToNumber:@1])
        {
            weakSelf.hasFollow = YES;
        }
        weakSelf.attentionBtn.selected = weakSelf.hasFollow;
        
    } failure:^(BOOL failuer, NSError *error) {
        
    }];
}

//关注用户
- (void)didFollow:(NSNumber *)followerId {
    WEAKSELF
    NSDictionary *dic = @{@"userId":self.userId,
                          @"followerId":followerId,
                          @"isFollow":@"true"};
    [ENDNetWorkManager postWithPathUrl:@"/user/follow/follow" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        weakSelf.hasFollow = true;
        weakSelf.attentionBtn.selected = YES;
        [weakSelf whetherFollow:self.newsModel.user.userId];
    } failure:^(BOOL failuer, NSError *error) {
    }];
}
//取消关注
- (void)removeFollow:(NSNumber *)followerId {
    WEAKSELF
    NSDictionary *dic = @{@"userId":self.userId,
                          @"followerId":followerId,
                          @"isFollow":@"false"};
    [ENDNetWorkManager postWithPathUrl:@"/user/follow/follow" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        weakSelf.hasFollow = false;
        weakSelf.attentionBtn.selected = YES;
        [weakSelf whetherFollow:self.newsModel.user.userId];
    } failure:^(BOOL failuer, NSError *error) {
    }];
}

@end
