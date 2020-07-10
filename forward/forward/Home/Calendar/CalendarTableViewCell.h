//
//  CalendarTableViewCell.h
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuoteCalendarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalendarTableViewCell : UITableViewCell

@property (nonatomic, strong)QuoteCalendarModel *calendarModel;

@end

NS_ASSUME_NONNULL_END
