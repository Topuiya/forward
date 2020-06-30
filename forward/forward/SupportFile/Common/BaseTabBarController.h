//
//  BaseTabBarController.h
//  CyberGame
//
//  Created by apple on 2020/6/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxcAE_TabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTabBarController : UITabBarController

@property (nonatomic, strong) AxcAE_TabBar *axcTabBar;

@end

NS_ASSUME_NONNULL_END
