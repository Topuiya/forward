//
//  QuotesCollectionCell.m
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "QuotesCollectionCell.h"

@interface QuotesCollectionCell ()

@end

@implementation QuotesCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    self.titleLabel.text = dataArray[0];
    NSNumber *price = dataArray[2];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",price.doubleValue];
    NSNumber *up = dataArray[3];
    self.upLabel.text = [NSString stringWithFormat:@"%.2f",up.doubleValue];
    NSNumber *change = dataArray[4];
    self.changeLabel.text = [NSString stringWithFormat:@"%.2f",change.doubleValue];
    
    if (change.doubleValue > 0.0f) {
        self.priceLabel.textColor = Rise;
        self.upLabel.textColor = Rise;
        self.changeLabel.textColor = Rise;
    }else if (change.doubleValue == 0.0f) {
        self.priceLabel.textColor = [UIColor colorWithHexString:@"333333"];
        self.upLabel.textColor = [UIColor colorWithHexString:@"333333"];
        self.changeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
    else {
        self.priceLabel.textColor = Fall;
        self.upLabel.textColor = Fall;
        self.changeLabel.textColor = Fall;
    }
    
}

@end
