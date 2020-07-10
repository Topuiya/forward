//
//  UserModel.h
//  forward
//
//  Created by apple on 2020/7/7.
//  Copyright © 2020 zzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : BaseModel

@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *pwd;

@property (nonatomic, copy)NSString *head;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, strong)NSNumber *followCount;
@property (nonatomic, strong)NSNumber *fansCount;
@property (nonatomic, copy)NSString *signature;
@property (nonatomic, strong)NSNumber *userId;
@property (nonatomic, copy)NSString *projectKey;

@end

NS_ASSUME_NONNULL_END
