//
//  TimeNewsHeadView.h
//  forward
//
//  Created by apple on 2020/7/2.
//  Copyright © 2020 zzh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeNewsHeadView : UIView

@property (nonatomic, copy)void (^didClickSortButtonBlock)(NSInteger btnTag);

@end

NS_ASSUME_NONNULL_END
