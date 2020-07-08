//
//  ForgetPwdVC.m
//  forward
//
//  Created by apple on 2020/7/8.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "ForgetPwdVC.h"
#import "MyCodeView.h"
#import "UserModel.h"

@interface ForgetPwdVC () <UITextFieldDelegate,MyCodeViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *captchaTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;
@property (weak, nonatomic) IBOutlet UITextField *repeatPwdTextF;

@property (weak, nonatomic)MyCodeView *myCodeView;
@property (weak, nonatomic)UIView *coverView;
@property (copy, nonatomic)NSString *picCode;
@end

@implementation ForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hbd_barAlpha = 1;
    [self setForTextField];
}
//设置输入框
- (void)setForTextField {
    self.phoneTextF.delegate = self;
    self.captchaTextF.delegate = self;
    self.pwdTextF.delegate = self;
    self.repeatPwdTextF.delegate = self;
    //修改光标颜色
    self.phoneTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    self.captchaTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    self.pwdTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    self.repeatPwdTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
}
//点击获取验证码按钮
- (IBAction)getCaptchaBtnBtn:(id)sender {
    
    MyCodeView *codeView = [[MyCodeView alloc] initWithFrame:CGRectMake(0, 0, 300, 220)];
    codeView.layer.cornerRadius = 20;
    //设置代理
    codeView.delegate = self;
    self.myCodeView = codeView;
    //弹出窗口
    [self addCoverView];
    //获取图形验证码
    [self getPicCode];
    
}
//点击完成按钮
- (IBAction)completeBtnClick:(id)sender {
    //提交
    [self alterPwd];
}

//弹出窗口
- (void)addCoverView
{
    UIView *coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor whiteColor];
    
    self.myCodeView.alpha = 0;
    self.myCodeView.center = coverView.center;
    CGRect frame = self.myCodeView.frame;
    frame.size = CGSizeMake(0, 0);
    self.myCodeView.frame = frame;
    [coverView addSubview:self.myCodeView];
    _coverView = coverView;
    
    NSArray *array = [UIApplication sharedApplication].windows;
    UIWindow *keyWindow = [array objectAtIndex:0];
    [keyWindow addSubview:_coverView];
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.backgroundColor = RGBA(1, 1, 1, 0.6);
        self.myCodeView.alpha = 1;
        CGRect frame = self.myCodeView.frame;
        frame.size = CGSizeMake(300, 220);
        self.myCodeView.frame = frame;
    }];
}
//移除弹窗
- (void)removeCoverView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.myCodeView.alpha = 0;
        CGRect frame = self.myCodeView.frame;
        frame.size = CGSizeMake(0, 0);
        self.myCodeView.frame = frame;
    }completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
    }];
}

//获取验证码图片
- (void)getPicCode
{
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/system/sendVerify" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSString *dataStr = result[@"data"];
        NSData *imgData = [[NSData alloc]initWithBase64EncodedString:dataStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image = [UIImage imageWithData:imgData];
        weakSelf.myCodeView.numImageView.image = image;
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"获取图形验证码失败" afterHideTime:DELAYTiME];
    }];
}
//发送验证码
- (void)sendCode
{
    WEAKSELF
    if([self.picCode isEqualToString:@""])
    {
        self.picCode = @" ";
    }
    NSDictionary *dic = @{@"phone":self.phoneTextF.text,
                          @"type":@(3),
                          @"project":ProjectCategory,
                          @"code":self.picCode};
    [ENDNetWorkManager postWithPathUrl:@"/system/sendCode" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        [self removeCoverView];
        //        [self.scheduleStoreLabel startCountDown];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.coverView Message:@"发送验证码失败" afterHideTime:DELAYTiME];
    }];
}
//重置密码
- (void)alterPwd {
    WEAKSELF
    NSDictionary *dic = @{@"phone":self.phoneTextF.text,
                          @"newPassword":self.pwdTextF.text,
                          @"confirmPassword":self.repeatPwdTextF.text,
                          @"code":self.captchaTextF.text,
                          @"project":ProjectCategory};
    [ENDNetWorkManager postWithPathUrl:@"/system/resetPassword" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        //返回
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.coverView Message:@"修改密码失败!"  afterHideTime:DELAYTiME];
    }];
}

#pragma mark - MyCodeViewDelegate
//  点击图片
- (void)didSelectedNumImageView {
    //刷新验证码
    [self getPicCode];
}
//  点击关闭按钮
- (void)didClicMyCodeCloseBtn {
    [self removeCoverView];
}
//  点击确认按钮
- (void)didClickMyCodeSureBtn:(MyCodeView *)myCodeView inputCode:(NSString *)inputCode {
    self.picCode = inputCode;
    [self sendCode];
}

@end
