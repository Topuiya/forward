//
//  AttentionCollectionCell.m
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "AttentionCollectionCell.h"

@interface AttentionCollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation AttentionCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.borderColor = [[UIColor colorWithHexString:@"#E6E6E6"] CGColor];
}

@end
