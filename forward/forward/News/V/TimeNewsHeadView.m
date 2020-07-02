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
            button.selected = YES;
            _selectedBtn = button;
        }
    }
}

- (void)didClickSortButton:(UIButton *)button {
    self.selectedBtn = button;
    button.selected = !button.selected;
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton *btn = self.btnArray[i];
        if (button.tag == i) {
            btn.selected = btn.selected;
            if (_didClickSortButtonBlock) {
                _didClickSortButtonBlock(button.tag);
            }
        }else {
            btn.selected = NO;
        }
        
        [self buttonColor:button];
    }
    UIButton *btn = self.btnArray[button.tag];
    if (btn.selected) {
        //点击之后直接修改button的颜色
//        [button setTitleColor:[UIColor colorWithHexString:@"#FB6E63"] forState:UIControlStateNormal];
//        //选中之后的颜色
//        button.layer.borderColor = [[UIColor colorWithHexString:@"#FDD9C1"] CGColor];
        [self buttonColor:button];

    }else {
        //选中之后再次点击的颜色
//        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
//        button.layer.borderColor = [[UIColor colorWithHexString:@"#F1F1F0"] CGColor];
        [self selectButtonColor:button];
    }
}

- (void)buttonColor:(UIButton *)btn {
//    if (btn.selected == NO) {
        [btn setTitleColor:[UIColor colorWithHexString:@"#FB6E63"] forState:UIControlStateNormal];
        btn.layer.borderColor = [[UIColor colorWithHexString:@"#FDD9C1"] CGColor];
//    }
//    else {
//        //选中之后的颜色
//        btn.layer.borderColor = [[UIColor colorWithHexString:@"#666666"] CGColor];
//        //点击之后直接修改button的颜色
//        [btn setTitleColor:[UIColor colorWithHexString:@"#FB6E63"] forState:UIControlStateNormal];
//    }
    
}

- (void)selectButtonColor:(UIButton *)btn {
    //选中之后的颜色
    btn.layer.borderColor = [[UIColor colorWithHexString:@"#666666"] CGColor];
    //点击之后直接修改button的颜色
    [btn setTitleColor:[UIColor colorWithHexString:@"#F1F1F0"] forState:UIControlStateNormal];
}

@end
