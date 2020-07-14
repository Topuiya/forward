//
//  SignInView.h
//  forward
//
//  Created by apple on 2020/7/13.
//  Copyright © 2020 zzh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignInView : UIView
@property (nonatomic, copy)void (^selectedSureBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
