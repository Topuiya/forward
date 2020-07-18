//
//  CommentModel.h
//  Futures0628
//
//  Created by Francis on 2020/7/15.
//

#import "BaseModel.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : BaseModel
@property(nonatomic, copy) NSString *content;
@property(nonatomic, assign) double publishTime;
@property (nonatomic, strong)UserModel *user;
@end

NS_ASSUME_NONNULL_END
