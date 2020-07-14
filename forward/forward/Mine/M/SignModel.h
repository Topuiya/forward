//
//  SignModel.h
//  forward
//
//  Created by apple on 2020/7/13.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignModel : BaseModel
//连续签到的次数
@property (nonatomic, strong)NSNumber *continueTimes;
@property (nonatomic, assign)double time;
@end

NS_ASSUME_NONNULL_END
