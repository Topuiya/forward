//
//  FeedbackVC.m
//  forward
//
//  Created by apple on 2020/7/15.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "FeedbackVC.h"
#import <HBDNavigationBar.h>

@interface FeedbackVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *feedTextF;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.hbd_tintColor = [UIColor colorWithHexString:@"333333"];
    self.feedTextF.delegate = self;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = [[UIColor colorWithHexString:@"#E6E6E6"] CGColor];
    
}
- (IBAction)selectedBtnClick:(id)sender {
    [Toast makeText:self.view Message:@"提交成功!" afterHideTime:DELAYTiME];
}
@end
