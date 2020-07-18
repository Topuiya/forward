//
//  MXZRecommandTalkModel.h
//  futures
//
//  Created by Francis on 2020/5/29.
//  Copyright © 2020 Francis. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RecommandTalkModel : BaseModel

@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *picture;
@property(nonatomic, assign) double publishTime;
@property(nonatomic, assign) NSInteger recommandCount;
@property(nonatomic, assign) BOOL isShield;
@property(nonatomic, strong) NSNumber *talkId;

@property (nonatomic, strong)UserModel *user;
@end

NS_ASSUME_NONNULL_END
