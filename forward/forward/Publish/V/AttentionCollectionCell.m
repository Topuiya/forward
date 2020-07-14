//
//  AttentionCollectionCell.m
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "AttentionCollectionCell.h"
#import "UserModel.h"

@interface AttentionCollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *log;
@property (nonatomic, assign) bool hasFollow;
@end

@implementation AttentionCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.borderColor = [[UIColor colorWithHexString:@"#E6E6E6"] CGColor];
}

- (void)setRecommandModel:(UserModel *)recommandModel {
    _recommandModel = recommandModel;
    
    NSURL *picURL = [NSURL URLWithString:recommandModel.head];
    [self.headImageView sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"denglutouxiang"]];
    self.nameLabel.text = recommandModel.nickName;
    self.signatureLabel.text = recommandModel.signature;
    
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSNumber *hasLog = [EGHCodeTool getOBJCWithSavekey:isLog];
    self.userId = user.userId;
    self.log = hasLog;
    if ([_log  isEqual: @1]) {
        [self followUser];
    }
}

- (IBAction)attentionBtnClick:(id)sender {
    if ([_log  isEqual: @1]) {
        if (self.hasFollow == NO) {
            [self didFollow:_recommandModel.userId];
        }
        else if (self.hasFollow == YES){
            [self removeFollow:_recommandModel.userId];
        }
        self.attentionBtn.selected = self.hasFollow;
    }
}

- (void)followUser {
    //判断用户是否登录
    if ([_log  isEqual: @1]) {
        //用户登录之后判断是否关注过该用户
        [self whetherFollow:self.recommandModel.userId];
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
        [weakSelf whetherFollow:self.recommandModel.userId];
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
        [weakSelf whetherFollow:self.recommandModel.userId];
    } failure:^(BOOL failuer, NSError *error) {
    }];
}

@end
