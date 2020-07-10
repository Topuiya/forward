//
//  DetailHeadTableCell.m
//  forward
//
//  Created by apple on 2020/7/8.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "DetailHeadTableCell.h"
#import "UserModel.h"

@interface DetailHeadTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//关注按钮
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//点赞按钮
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
//是否关注该用户
@property (nonatomic, assign) BOOL isFollow;
@end

@implementation DetailHeadTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.attentionBtn addTarget:self action:@selector(didClickAttentionBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    
    NSURL *headURL = [NSURL URLWithString:newsModel.user.head];
    [self.headImageView sd_setImageWithURL:headURL placeholderImage:[UIImage imageNamed:@"denglutouxiang"]];
    self.nameLabel.text = newsModel.user.nickName;

    [self followUser];
}
//点击关注按钮
- (void)didClickAttentionBtn:(UIButton *)button {
    //取出本地的数据
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    if ([log  isEqual: @1]) {
        if (self.isFollow == NO) {
            [self didFollow:_newsModel.user.userId];
        }
        else if (self.isFollow == YES){
            [self removeFollow:_newsModel.user.userId];
        }
        self.attentionBtn.selected = self.isFollow;
    }
}

- (void)followUser {
    //取出本地的数据
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    //判断用户是否登录
    if ([log  isEqual: @1]) {
        //用户登录之后判断是否关注过该用户
        [self whetherFollow:_newsModel.user.userId];
    }
}

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
            weakSelf.isFollow = NO;
        }
        else if([resultNum isEqualToNumber:@1])
        {
            weakSelf.isFollow = YES;
        }
        weakSelf.attentionBtn.selected = weakSelf.isFollow;
        
    } failure:^(BOOL failuer, NSError *error) {
        
    }];
}

//关注用户
- (void)didFollow:(NSNumber *)followerId {
    WEAKSELF
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSDictionary *dic = @{@"userId":user.userId,
                          @"followerId":followerId,
                          @"isFollow":@"true"};
    [ENDNetWorkManager postWithPathUrl:@"/user/follow/follow" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        weakSelf.isFollow = true;
        weakSelf.attentionBtn.selected = YES;
        [weakSelf whetherFollow:self.newsModel.user.userId];
    } failure:^(BOOL failuer, NSError *error) {
    }];
}
//取消关注
- (void)removeFollow:(NSNumber *)followerId {
    WEAKSELF
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSDictionary *dic = @{@"userId":user.userId,
                          @"followerId":followerId,
                          @"isFollow":@"false"};
    [ENDNetWorkManager postWithPathUrl:@"/user/follow/follow" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        weakSelf.isFollow = false;
        weakSelf.attentionBtn.selected = YES;
        [weakSelf whetherFollow:self.newsModel.user.userId];
    } failure:^(BOOL failuer, NSError *error) {
    }];
}

@end
