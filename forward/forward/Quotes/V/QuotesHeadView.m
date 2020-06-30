//
//  QuotesHeadView.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "QuotesHeadView.h"

@implementation QuotesHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"QuotesHeadView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}

@end
