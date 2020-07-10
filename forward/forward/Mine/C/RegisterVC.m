//
//  RegisterVC.m
//  forward
//
//  Created by apple on 2020/7/6.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "RegisterVC.h"
#import "MyCodeView.h"
#import "UserModel.h"

@interface RegisterVC () <MyCodeViewDelegate>
//获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *getNumBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *getNumTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextF;

//立即注册按钮
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (weak, nonatomic)MyCodeView *myCodeView;
@property (weak, nonatomic)UIView *coverView;
//保存验证码
@property (copy, nonatomic)NSString *picCode;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改光标颜色
    self.phoneTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    self.getNumTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    self.pwdTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    self.confirmPwdTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    
    [self setGetNumBtnStyle];
    
    self.getNumBtn.enabled = NO;
    //UIControlEventEditingChanged
    [self.phoneTextF addTarget:self action:@selector(didPhoneTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    
    [self.getNumBtn addTarget:self action:@selector(didClickGetNumButton) forControlEvents:UIControlEventTouchUpInside];
    [self.registBtn addTarget:self action:@selector(didClickRegistBtn) forControlEvents:UIControlEventTouchUpInside];
}
//设置获取验证码按钮的样式
- (void)setGetNumBtnStyle {
    self.getNumBtn.tintColor = UIColor.whiteColor;
    
    CAGradientLayer *getBtnLayer = [CAGradientLayer layer];
    getBtnLayer.frame = CGRectMake(0, 0, _getNumBtn.frame.size.width, _getNumBtn.frame.size.height);
    getBtnLayer.startPoint = CGPointMake(0, 0);
    getBtnLayer.endPoint = CGPointMake(1, 1);
    getBtnLayer.locations = @[@(0.0),@(1.0f)];
    getBtnLayer.colors = @[(__bridge id)RGB(251, 182, 99).CGColor,(__bridge id)RGB(251, 100, 99).CGColor];
    getBtnLayer.cornerRadius = 12.5;
    [self.getNumBtn.layer addSublayer:getBtnLayer];
    
}

#pragma mark - TextField监听
- (void)didPhoneTextFieldChanged {
    if (self.phoneTextF.text.length != 11) {
        self.getNumBtn.enabled = NO;
    } else {
        self.getNumBtn.enabled = YES;
    }
}

- (void)didClickGetNumButton {
    MyCodeView *codeView = [[MyCodeView alloc] initWithFrame:CGRectMake(0, 0, 300, 220)];
    codeView.layer.cornerRadius = 20;
    //设置代理
    codeView.delegate = self;
    self.myCodeView = codeView;
    [self addCoverView];
    [self getPicCode];
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
    NSDictionary *dic = @{@"phone":self.phoneTextF.text,@"type":@(1),@"project":ProjectCategory,@"code":self.picCode};
    [ENDNetWorkManager postWithPathUrl:@"/system/sendCode" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        [self removeCoverView];
        //        [self.scheduleStoreLabel startCountDown];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.coverView Message:@"发送验证码失败" afterHideTime:DELAYTiME];
    }];
}
//注册
- (void)regist
{
    WEAKSELF
    NSDictionary *dic = @{@"phone":self.phoneTextF.text,@"password":self.pwdTextF.text,@"confirmPassword":self.confirmPwdTextF.text,@"code":self.getNumTextF.text,@"type":@(1),@"project":ProjectCategory};
    [ENDNetWorkManager postWithPathUrl:@"/system/register" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"注册失败" afterHideTime:DELAYTiME];
    }];
}


//点击立即注册按钮
- (void)didClickRegistBtn {
    [self regist];
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
