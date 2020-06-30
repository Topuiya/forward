//
//  HomeTitleView.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "HomeTitleView.h"

@implementation HomeTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"HomeTitleView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}

@end
