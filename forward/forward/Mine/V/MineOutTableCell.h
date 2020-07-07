//
//  MineOutTableCell.h
//  forward
//
//  Created by apple on 2020/7/2.
//  Copyright © 2020 zzh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineOutTableCell : UITableViewCell

@property (nonatomic, copy)void (^didClickOutButtonBlock)(void);

@end

NS_ASSUME_NONNULL_END
