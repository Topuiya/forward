//
//  CommentModel.m
//  Futures0628
//
//  Created by Francis on 2020/7/15.
//

#import "CommentModel.h"

@implementation CommentModel
+ (NSDictionary*) JSONKeyPathsByPropertyKey{
    return @{
             NSStringFromSelector(@selector(content)):@"content",
             NSStringFromSelector(@selector(user)):@"user",
             NSStringFromSelector(@selector(publishTime)):@"publishTime",
             };
}

+(NSValueTransformer *)userJSONTransformer{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSError *newError;
        UserModel *model = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:value error:&newError];
        return model;
    }];
}
@end
