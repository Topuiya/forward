//
//  UserModel.m
//  forward
//
//  Created by apple on 2020/7/7.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (NSDictionary*) JSONKeyPathsByPropertyKey{
    return @{
        NSStringFromSelector(@selector(phone)):@"phone",
        NSStringFromSelector(@selector(pwd)):@"password",
        
        NSStringFromSelector(@selector(head)):@"head",
        NSStringFromSelector(@selector(nickName)):@"nickName",
        NSStringFromSelector(@selector(followCount)):@"followCount",
        NSStringFromSelector(@selector(fansCount)):@"fansCount",
        NSStringFromSelector(@selector(signature)):@"signature",
        NSStringFromSelector(@selector(userId)):@"id",
        NSStringFromSelector(@selector(projectKey)):@"projectKey",
    };
}

@end
