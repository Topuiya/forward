//
//  CalendarTableViewCell.m
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "CalendarTableViewCell.h"

@interface CalendarTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *showBtn;

@end

@implementation CalendarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 发布按钮设置
    self.showBtn.layer.borderColor = [[UIColor colorWithHexString:@"#666666"] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
