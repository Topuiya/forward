//
//  PwdLoginVC.m
//  forward
//
//  Created by apple on 2020/7/6.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "PwdLoginVC.h"
#import "JXCategoryTitleView.h"
#import "RegisterVC.h"
#import "UserModel.h"
#import "ForgetPwdVC.h"

@interface PwdLoginVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *getNumBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

//最底立即注册
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;

@end

@implementation PwdLoginVC

- (void)viewDidLoad {
    //隐藏提示文字
    self.promptLabel.hidden = YES;
//    if (SCREEN_WIDTH == 375) {
//        self.bottomViewHeight.constant = 350;
//    }
    
    self.bottomView.layer.borderWidth = 1;
    self.bottomView.layer.borderColor = [[UIColor colorWithHexString:@"#F1B5B1"] CGColor];
    
    self.getNumBtn.tintColor = UIColor.whiteColor;
    
    self.phoneTextF.delegate = self;
    self.pwdTextF.delegate = self;
    //修改光标颜色
    self.phoneTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    self.pwdTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];

    [self.registerBtn addTarget:self action:@selector(didRdegisterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetBtn addTarget:self action:@selector(didForgetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didRdegisterBtnClick:(UIButton *)button {
    RegisterVC *vc = RegisterVC.new;
    [self presentViewController:vc animated:YES completion:^{
    }];
}
- (void)didForgetBtnClick:(UIButton *)button {
    ForgetPwdVC *vc = ForgetPwdVC.new;
    [self presentViewController:vc animated:YES completion:^{
    }];
}

- (UIView *)listView {
    return self.view;
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    [self loginWithPwd];
}
//使用密码登录
- (void)loginWithPwd
{
    WEAKSELF
    NSDictionary *dic = @{@"phone":self.phoneTextF.text,
                          @"password":self.pwdTextF.text,
                          @"type":@(1),
                          @"project":ProjectCategory};
    [ENDNetWorkManager getWithPathUrl:@"/system/login" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        UserModel *user = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:result[@"data"] error:&error];
        //登录之后归档数据
        [EGHCodeTool archiveOJBC:user saveKey:userModel];
        NSNumber *islog = @1;
        [EGHCodeTool archiveOJBC:islog saveKey:isLog];
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"登录失败" afterHideTime:DELAYTiME];
    }];
}

@end
