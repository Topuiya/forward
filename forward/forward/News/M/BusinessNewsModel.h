//
//  BusinessNewsModel.h
//  forward
//
//  Created by apple on 2020/7/9.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BusinessNewsModel : BaseModel

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, assign) double time;


@end

NS_ASSUME_NONNULL_END
