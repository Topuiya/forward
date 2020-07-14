//
//  MyCodeView.h
//  forward
//
//  Created by apple on 2020/7/7.
//  Copyright © 2020 zzh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MyCodeView;

@protocol MyCodeViewDelegate <NSObject>

- (void)didSelectedNumImageView;
- (void)didClicMyCodeCloseBtn;
- (void)didClickMyCodeSureBtn:(MyCodeView *)myCodeView inputCode:(NSString *)inputCode;

@end

@interface MyCodeView : UIView
//图形验证码
@property (weak, nonatomic) IBOutlet UIImageView *numImageView;
@property (weak, nonatomic) id <MyCodeViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
