//
//  HomeHeaderView.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewTop;
@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"HomeHeaderView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    if (kIsIPhoneX_Series) {
        self.searchViewTop.constant += 20;
    }
    return self;
}

@end
