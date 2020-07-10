//
//  CheckInSuccessView.m
//  Futures
//
//  Created by Ssiswent on 2020/6/19.
//  Copyright © 2020 Ssiswent. All rights reserved.
//

#import "CheckInSuccessView.h"

@implementation CheckInSuccessView

+ (instancetype)checkInSuccessView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CheckInSuccessView class]) owner:nil options:nil] firstObject];
}


@end
