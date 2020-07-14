//
//  SignInView.m
//  forward
//
//  Created by apple on 2020/7/13.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "SignInView.h"

@interface SignInView ()
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@end

@implementation SignInView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"SignInView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (IBAction)clickSureBtn:(id)sender {
    if (self.selectedSureBtnBlock) {
        self.selectedSureBtnBlock();
    }
}

@end
