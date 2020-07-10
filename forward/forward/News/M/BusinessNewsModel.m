//
//  BusinessNewsModel.m
//  forward
//
//  Created by apple on 2020/7/9.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "BusinessNewsModel.h"

@implementation BusinessNewsModel

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        NSStringFromSelector(@selector(content)):@"content",
        NSStringFromSelector(@selector(country)):@"country",
        NSStringFromSelector(@selector(region)):@"region",
        NSStringFromSelector(@selector(time)):@"time",
    };
}

@end
