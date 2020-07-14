//
//  MyCodeView.m
//  forward
//
//  Created by apple on 2020/7/7.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "MyCodeView.h"

@interface MyCodeView ()
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UITextField *numTextF;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation MyCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"MyCodeView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numTextF.tintColor = [UIColor colorWithHexString:@"#FBB663"];
    
    self.numImageView.userInteractionEnabled = YES;
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didSelectedNumImageView)];
    [self.numImageView addGestureRecognizer:tap];
    
    [self.closeBtn addTarget:self action:@selector(didClicMyCodeCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(didClickMyCodeSureBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didSelectedNumImageView {
    if([self.delegate respondsToSelector:@selector(didSelectedNumImageView)])
    {
        [self.delegate didSelectedNumImageView];
    }
}

- (void)didClicMyCodeCloseBtn {
    if ([self.delegate respondsToSelector:@selector(didClicMyCodeCloseBtn)]) {
        [self.delegate didClicMyCodeCloseBtn];
    }
}

- (void)didClickMyCodeSureBtn {
    if ([self.delegate respondsToSelector:@selector(didClickMyCodeSureBtn:inputCode:)]) {
        [self.delegate didClickMyCodeSureBtn:self inputCode:self.numTextF.text];
    }
}

@end
