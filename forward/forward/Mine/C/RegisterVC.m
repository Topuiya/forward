//
//  RegisterVC.m
//  forward
//
//  Created by apple on 2020/7/6.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UIButton *getNumBtn;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
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


@end
