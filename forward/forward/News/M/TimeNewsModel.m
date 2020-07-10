//
//  TimeNewsModel.m
//  forward
//
//  Created by apple on 2020/7/9.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "TimeNewsModel.h"

@implementation TimeNewsModel

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        NSStringFromSelector(@selector(content)):@"content",
        NSStringFromSelector(@selector(time)):@"time",
    };
}

@end
