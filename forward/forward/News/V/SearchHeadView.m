//
//  SearchHeadView.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "SearchHeadView.h"

@implementation SearchHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"SearchHeadView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}

@end
