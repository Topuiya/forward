//
//  TimeNewsModel.h
//  forward
//
//  Created by apple on 2020/7/9.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimeNewsModel : BaseModel

@property (nonatomic, copy)NSString *content;
@property (nonatomic, assign)NSNumber *time;

@end

NS_ASSUME_NONNULL_END
