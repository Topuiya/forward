//
//  SignModel.m
//  forward
//
//  Created by apple on 2020/7/13.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "SignModel.h"

@implementation SignModel
+ (NSDictionary*) JSONKeyPathsByPropertyKey{
    return @{
             NSStringFromSelector(@selector(continueTimes)):@"continueTimes",
             NSStringFromSelector(@selector(time)):@"time",
             };
}
@end
