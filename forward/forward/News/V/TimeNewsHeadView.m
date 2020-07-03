//
//  TimeNewsHeadView.m
//  forward
//
//  Created by apple on 2020/7/2.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "TimeNewsHeadView.h"

@interface TimeNewsHeadView ()
/** 临时按钮(用来记录哪个按钮为选中状态) */
@property (nonatomic, weak) UIButton *selectedBtn;

@property(strong, nonatomic) NSMutableArray *btnArray;

@end

@implementation TimeNewsHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"TimeNewsHeadView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"全部", @"宏观", @"股市", @"国际", @"观点", nil];
    CGFloat w = SCREEN_WIDTH / nameArray.count;
    self.btnArray = [NSMutableArray array];
    for (int i = 0; i < nameArray.count; i++) {
        CGFloat x = w * i;
        UIButton *button = [UIButton new];
        
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        //button的样式
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        button.layer.borderColor = [[UIColor colorWithHexString:@"#F1F1F0"] CGColor];
        //设置边框宽度
        button.layer.borderWidth = 1.0f;
        //给按钮设置角的弧度
        button.layer.cornerRadius = 4.0f;
        
        button.frame = CGRectMake(x + 10, 10, w - 20, 25);
        [self addSubview:button];
        //给按钮设置tag
        button.tag = i;
        //监听点击
        [button addTarget:self action:@selector(didClickSortButton:) forControlEvents:UIControlEventTouchUpInside];
        //将按钮保存在数组
        [self.btnArray addObject:button];
        
        if (button.tag == 0) {
            [self selectButtonColor:button];
        }
    }
}

- (void)didClickSortButton:(UIButton *)sender {
    self.selectedBtn = sender;
    sender.selected = !sender.selected;
    
    for (NSInteger i = 0; i < [self.btnArray count]; i++) {
        UIButton *tempBtn = self.btnArray[i];
        if (sender.tag == i) {
            tempBtn.selected = sender.selected;
        } else {
            tempBtn.selected = NO;
        }
        //  改变按钮的tempBtn的状态
        [self unSelectButtonColor:tempBtn];
    }
    
    UIButton *btn = self.btnArray[sender.tag];
    if (btn.selected) {
        //改变btn的状态
        [self selectButtonColor:btn];
    } else {
        //再次点击
    }
    
}

- (void)selectButtonColor:(UIButton *)btn {
    btn.layer.borderColor = [[UIColor colorWithHexString:@"#FB6463"] CGColor];
    [btn setTitleColor:[UIColor colorWithHexString:@"#FB6E63"] forState:UIControlStateNormal];
}

- (void)unSelectButtonColor:(UIButton *)btn {
    btn.layer.borderColor = [[UIColor colorWithHexString:@"#F1F1F0"] CGColor];
    [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
}

@end
