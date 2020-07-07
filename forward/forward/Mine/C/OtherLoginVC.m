//
//  OtherLoginVC.m
//  forward
//
//  Created by apple on 2020/7/6.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "OtherLoginVC.h"
#import "JXCategoryTitleView.h"
#import "MyCodeView.h"
#import "UserModel.h"

@interface OtherLoginVC () <MyCodeViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UIButton *getNumBtn;
@property (weak, nonatomic) IBOutlet UITextField *captchaTextF;

@property (weak, nonatomic)MyCodeView *myCodeView;
@property (weak, nonatomic)UIView *coverView;
@property (copy, nonatomic)NSString *phone;
@property (copy, nonatomic)NSString *pwd;
@end

@implementation OtherLoginVC

- (void)viewDidLoad {
    self.bottomView.layer.borderWidth = 1;
    self.bottomView.layer.borderColor = [[UIColor colorWithHexString:@"#F1B5B1"] CGColor];
    //修改光标颜色
    self.phoneTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    self.captchaTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    [self.getNumBtn addTarget:self action:@selector(clickGetNumButton) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    
}
- (UIView *)listView {
    return self.view;
}

- (void)clickGetNumButton {
    MyCodeView *codeView = [[MyCodeView alloc] initWithFrame:CGRectMake(0, 0, 300, 220)];
    codeView.layer.cornerRadius = 20;
    //设置代理
    codeView.delegate = self;
    self.myCodeView = codeView;
}

//登录按钮点击
- (void)clickLoginButton {
}


@end
