//
//  HomeNewsModel.m
//  forward
//
//  Created by apple on 2020/7/8.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "HomeNewsModel.h"

@implementation HomeNewsModel

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
        NSStringFromSelector(@selector(content)):@"content",
        NSStringFromSelector(@selector(publishTime)):@"publishTime",
        NSStringFromSelector(@selector(picture)):@"picture",
        NSStringFromSelector(@selector(user)):@"user",
    };
}

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSError *newError;
        UserModel *model = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:value error:&newError];
        return model;
    }];
}

@end
