//
//  AppDelegate.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "AppDelegate.h"

#import "HomeVC.h"
#import "QuotesVC.h"
#import "PublishVC.h"
#import "NewsVC.h"
#import "MineVC.h"
#import "CZ_NEWMarketVC.h"

#import "BaseTabBarController.h"
#import <IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//
    HBDNavigationController *homeNav = [[HBDNavigationController alloc] initWithRootViewController:[HomeVC new]];
    HBDNavigationController *quotesNav = [[HBDNavigationController alloc] initWithRootViewController:[CZ_NEWMarketVC new]];
    HBDNavigationController *publishNav = [[HBDNavigationController alloc] initWithRootViewController:[PublishVC new]];
    HBDNavigationController *newsNav = [[HBDNavigationController alloc] initWithRootViewController:[NewsVC new]];
    HBDNavigationController *mineNav = [[HBDNavigationController alloc] initWithRootViewController:[MineVC new]];
////
//    //开启AxcAE_TabBar
    BaseTabBarController *tabBarVC = [BaseTabBarController new];
    tabBarVC.viewControllers = @[homeNav,quotesNav,publishNav,newsNav,mineNav];
    self.window.rootViewController = tabBarVC;
    
    [self.window makeKeyAndVisible];
    
    //默认开启IQKeyboard键盘
    [IQKeyboardManager sharedManager];
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].toolbarManageBehaviour = YES;
    return YES;
}



@end
