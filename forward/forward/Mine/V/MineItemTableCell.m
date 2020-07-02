//
//  MineItemTableCell.m
//  forward
//
//  Created by apple on 2020/7/2.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "MineItemTableCell.h"
#import "MineTitleModel.h"

@interface MineItemTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation MineItemTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(MineTitleModel *)model {
    _model = model;
    self.titleLabel.text = model.titleStr;
    self.detailLabel.text = model.detailStr;
    if (model.detailStr == nil) {
        self.detailLabel.hidden = YES;
    }else {
        self.detailLabel.hidden = NO;
    }
    
}

@end
