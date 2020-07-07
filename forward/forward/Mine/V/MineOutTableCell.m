//
//  MineOutTableCell.m
//  forward
//
//  Created by apple on 2020/7/2.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "MineOutTableCell.h"

@interface MineOutTableCell ()
@property (weak, nonatomic) IBOutlet UIButton *outBtn;

@end

@implementation MineOutTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.outBtn addTarget:self action:@selector(clickOutButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickOutButton:(UIButton *)button {
    if (_didClickOutButtonBlock) {
        _didClickOutButtonBlock();
    }
}

@end
