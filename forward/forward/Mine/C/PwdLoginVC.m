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

@interface PwdLoginVC ()

@property (weak, nonatomic) IBOutlet UIButton *getNumBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@end

@implementation PwdLoginVC

- (void)viewDidLoad {
    if (SCREEN_WIDTH == 375) {
        self.bottomViewHeight.constant = 350;
    }
    
    self.getNumBtn.tintColor = UIColor.whiteColor;
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.cornerRadius = 12.5;
    gl.frame = CGRectMake(0,0,_getNumBtn.frame.size.width,_getNumBtn.frame.size.height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.locations = @[@(0.0),@(1.0f)];
    gl.colors = @[(__bridge id)RGB(251, 182, 99).CGColor,(__bridge id)RGB(251, 100, 99).CGColor];
    [self.getNumBtn.layer addSublayer:gl];
    
    [self.registerBtn addTarget:self action:@selector(didRdegisterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didRdegisterBtnClick:(UIButton *)button {
    RegisterVC *vc = RegisterVC.new;
    [self presentViewController:vc animated:YES completion:^{
    }];
}

- (UIView *)listView {
    return self.view;
}

@end
