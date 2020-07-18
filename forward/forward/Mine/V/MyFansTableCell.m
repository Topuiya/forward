//
//  MyFansTableCell.m
//  forward
//
//  Created by apple on 2020/7/10.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "MyFansTableCell.h"
#import "UserModel.h"

@interface MyFansTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (nonatomic, assign) Boolean isFollow;
@end
@implementation MyFansTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedBtn.selected = NO;
    [self.selectedBtn addTarget:self action:@selector(didClickSelectedBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setFansModel:(MyFollowModel *)fansModel {
    _fansModel = fansModel;
    NSURL *headURL = [NSURL URLWithString:fansModel.head];
    [self.headImageView sd_setImageWithURL:headURL placeholderImage:[UIImage imageNamed:@"denglutouxiang"]];
    self.nameLabel.text = fansModel.nickName;
    
    [self whetherFollow:self.fansModel.userId];
}
//点击按钮->取消关注
- (void)didClickSelectedBtn {
    //取出本地的数据
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    if ([log  isEqual: @1]) {
        if (self.isFollow == NO) {
            [self didFollow:_fansModel.userId];
        }
        else if (self.isFollow == YES){
            [self removeFollow:_fansModel.userId];
        }
    }
}

//取消关注
- (void)removeFollow:(NSNumber *)followerId {
    WEAKSELF
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSDictionary *dic = @{@"userId":user.userId,
                          @"followerId":followerId,
                          @"isFollow":@"false"};
    [ENDNetWorkManager postWithPathUrl:@"/user/follow/follow" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
//        weakSelf.isFollow = NO;
        weakSelf.selectedBtn.selected = NO;
        [weakSelf whetherFollow:self.fansModel.userId];
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
//        weakSelf.isFollow = YES;
        weakSelf.selectedBtn.selected = YES;
        [weakSelf whetherFollow:self.fansModel.userId];
    } failure:^(BOOL failuer, NSError *error) {
    }];
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
        weakSelf.selectedBtn.selected = weakSelf.isFollow;
        
    } failure:^(BOOL failuer, NSError *error) {
        
    }];
}

@end
