//
//  TopicFootView.m
//  forward
//
//  Created by apple on 2020/7/2.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "TopicFootView.h"

@implementation TopicFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"TopicFootView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    return self;
}

@end
