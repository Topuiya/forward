//
//  DetailTableCell.h
//  forward
//
//  Created by apple on 2020/7/17.
//  Copyright © 2020 zzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailTableCell : UITableViewCell
@property (strong, nonatomic) CommentModel *commentModel;
@end

NS_ASSUME_NONNULL_END
