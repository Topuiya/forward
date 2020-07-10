//
//  HomeNewsModel.h
//  forward
//
//  Created by apple on 2020/7/8.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeNewsModel : BaseModel

@property (nonatomic, copy)NSString *content;
@property (nonatomic, assign)double publishTime;
@property (nonatomic, copy)NSString *picture;

@property (nonatomic, strong)UserModel *user;

@end

NS_ASSUME_NONNULL_END
