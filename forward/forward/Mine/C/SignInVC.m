//
//  SignInVC.m
//  forward
//
//  Created by apple on 2020/7/10.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "SignInVC.h"
#import <FSCalendar.h>
#import "DIYCalendarCell.h"
#import "UserModel.h"

@interface SignInVC () <FSCalendarDelegate,FSCalendarDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleY;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
//签到view
@property (weak, nonatomic) IBOutlet UIView *signInView;

@end

@implementation SignInVC
NSString *DIYCalendarCellID = @"DIYCalendarCell";

- (NSMutableArray<NSDate *> *)datesArray
{
    if(_datesArray == nil)
    {
        _datesArray = NSMutableArray.new;
    }
    return _datesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hbd_barAlpha = 0;
    self.hbd_tintColor = UIColor.whiteColor;
    self.title = @"每日签到";
    //导航栏标题和状态栏颜色:白
    self.hbd_blackBarStyle = YES;
    
    self.signInView.userInteractionEnabled = YES;
    UITapGestureRecognizer *signTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedSignInView)];
    [self.signInView addGestureRecognizer:signTap];
    
    self.calendar.delegate = self;
    self.calendar.dataSource = self;
//    self.calendar.userInteractionEnabled = NO;
    self.calendar.placeholderType = 0;
    self.calendar.backgroundColor = UIColor.clearColor;
    self.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh_ch"];
    
    self.calendar.appearance.headerTitleColor = [UIColor whiteColor];
    self.calendar.appearance.weekdayTextColor = [UIColor colorWithHexString:@"#5B5B5B"];
    self.calendar.appearance.titleDefaultColor = [UIColor colorWithHexString:@"#5B5B5B"];
    //星期简称
    self.calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    [self.calendar registerClass:[DIYCalendarCell class] forCellReuseIdentifier:DIYCalendarCellID];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
// MARK:点击签到
- (void)selectedSignInView {
    //改变签到View里的状态
    
    //弹出窗口
    
    //点击确定关闭窗口
}

// 判断是否是同一天
- (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}

// MARK:coverView
//弹出窗口
- (void)addSighCoverView
{
    
}
//移除窗口
- (void)removeSighCoverView
{
    
}

#pragma mark - FSCalendarDataSource

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    DIYCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:DIYCalendarCellID forDate:date atMonthPosition:monthPosition];
    cell.hasChecked = NO;
    if(self.datesArray.count != 0)
    {
        for (NSDate *checkedInDate in self.datesArray) {
            if([self isSameDay:date date2:checkedInDate])
            {
                cell.hasChecked = YES;
            }
        }
    }
    return cell;
}

// MARK: API
- (void)signNow
{
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    WEAKSELF
    NSDictionary *dic = @{@"userId":user.userId};
    [ENDNetWorkManager postWithPathUrl:@"/user/sign/signNow" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
//        weakSelf.checkInBtn.enabled = NO;
//        [self addCoverView1];
//        [self.datesArray addObject:[NSDate date]];
        [self.calendar reloadData];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"签到失败" afterHideTime:DELAYTiME];
    }];
}

@end
