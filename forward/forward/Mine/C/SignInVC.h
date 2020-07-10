//
//  SignInVC.h
//  forward
//
//  Created by apple on 2020/7/10.
//  Copyright © 2020 zzh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignInVC : UIViewController
@property (strong , nonatomic) NSArray *checkInList;
@property (strong , nonatomic) NSMutableArray <NSDate *> *datesArray;
@property (nonatomic, assign) BOOL hasCheckedIn;
@end

NS_ASSUME_NONNULL_END
