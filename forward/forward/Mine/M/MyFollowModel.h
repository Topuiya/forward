//
//  MyFollowModel.h
//  forward
//
//  Created by apple on 2020/7/10.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyFollowModel : BaseModel

@property (nonatomic, copy)NSString *head;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, strong)NSNumber *userId;

@end

NS_ASSUME_NONNULL_END
