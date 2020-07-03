//
//  HomeHeaderView.h
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HomeHeaderView;

@protocol HomeHeaderViewDelegate <NSObject>

- (void)didSelectedCarlendarView;

@end

@interface HomeHeaderView : UIView

@property (nonatomic, weak) id <HomeHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
