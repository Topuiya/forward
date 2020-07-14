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
#import "SignModel.h"
#import "SignInView.h"

@interface SignInVC () <FSCalendarDelegate,FSCalendarDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleY;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayMoney;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;


@property (weak, nonatomic) IBOutlet FSCalendar *calendar;

@property (nonatomic, strong)NSNumber *userId;
@property (strong, nonatomic) NSArray *signedArray;
@property (nonatomic, assign) bool hasSign;
//最外层圆形的签到view
@property (weak, nonatomic) IBOutlet UIView *signInView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeight;
//蒙层
@property (weak, nonatomic)UIView *coverView;
@property (strong, nonatomic)SignInView *signView;
@property (strong, nonatomic)SignModel *dataModel;
@end

@implementation SignInVC

NSString *DIYCalendarCellID = @"DIYCalendarCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hbd_barAlpha = 0;
    self.hbd_tintColor = UIColor.whiteColor;
    self.title = @"每日签到";
    //导航栏标题和状态栏颜色:白
    self.hbd_blackBarStyle = YES;
    
    if (kIsIPhoneX_Series) {
        _calendarHeight.constant = 350;
    } else {
        _calendarHeight.constant = 320;
    }
    [self setCalendarStyle];
    
    //取出本地的数据
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    self.userId = user.userId;
    
    if (_hasSign == YES) {
        self.signInView.userInteractionEnabled = YES;
        UITapGestureRecognizer *signTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedSignInView)];
        [self.signInView addGestureRecognizer:signTap];
    } else if (_hasSign == NO) {
        [self setSignViewState];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    //今天能否签到
    [self getHasSign];
    //获取签到历史
    [self getSignList];
}

- (void)setCalendarStyle {
    self.calendar.delegate = self;
        self.calendar.dataSource = self;
        self.calendar.userInteractionEnabled = NO;
        self.calendar.placeholderType = 0;
        self.calendar.backgroundColor = UIColor.clearColor;
        self.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh_ch"];
        
        self.calendar.appearance.headerTitleColor = [UIColor whiteColor];
        self.calendar.appearance.weekdayTextColor = [UIColor colorWithHexString:@"#5B5B5B"];
        self.calendar.appearance.titleDefaultColor = [UIColor colorWithHexString:@"#5B5B5B"];
        //星期简称
        self.calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
        //月份模式时，只显示当前月份
        self.calendar.placeholderType = FSCalendarPlaceholderTypeNone;
//        [self.calendar registerClass:[DIYCalendarCell class] forCellReuseIdentifier:DIYCalendarCellID];
}

// MARK:点击签到
- (void)selectedSignInView {
    SignInView *signView = [[SignInView alloc] initWithFrame:CGRectMake(0, 0, 264, 250)];
    signView.layer.cornerRadius = 20;
    WEAKSELF
    signView.selectedSureBtnBlock = ^{
        [weakSelf removeCoverView];
    };
    self.signView = signView;
    [self addCoverView];
    
    [self getSignNow];
    
    //改变签到View的状态
    [self setSignViewState];
}
- (void)setSignViewState {
    if (_hasSign == NO) {
        self.todayMoney.text = @"今天获得金币: 0";
        self.totalMoney.text = [NSString stringWithFormat:@"总金币: %lu",_signedArray.count * 5];
        
        self.titleLabel.text = @"已签到";
        self.titleY.constant = -20;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        self.line.hidden = NO;
        
        self.detailLabel.hidden = NO;
        if (_dataModel.continueTimes == nil) {
            self.detailLabel.text = @"连续0天";
        } else {
            self.detailLabel.text = [NSString stringWithFormat:@"连续%@天",_dataModel.continueTimes];
        }
    }
}

// MARK:coverView
//弹出窗口
- (void)addCoverView
{
    UIView *coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor whiteColor];
    self.signView.alpha = 0;
    self.signView.center = coverView.center;
    CGRect frame = self.signView.frame;
    frame.size = CGSizeMake(0, 0);
    self.signView.frame = frame;
    [coverView addSubview:self.signView];
    _coverView = coverView;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].windows[0];
    [keyWindow addSubview:_coverView];
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.backgroundColor = RGBA(1, 1, 1, 0.6);
        self.signView.alpha = 1;
        CGRect frame = self.signView.frame;
        frame.size = CGSizeMake(264, 250);
        self.signView.frame = frame;
    }];
}
//移除弹窗
- (void)removeCoverView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.signView.alpha = 0;
        CGRect frame = self.signView.frame;
        frame.size = CGSizeMake(0, 0);
        self.signView.frame = frame;
    }completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
    }];
}
- (void)didClickSureButton {
    [self removeCoverView];
}


// MARK: API
//今日是否签到
- (void)getHasSign {
    WEAKSELF
    NSDictionary *dic = @{@"userId":self.userId};
    [ENDNetWorkManager getWithPathUrl:@"/user/sign/hasSign" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        //返回一个bool
        NSNumber *hasSign = result[@"data"];
        if ([hasSign isEqual:@(NO)]) {
            self.hasSign = NO;
        } else {
            self.hasSign = YES;
        }
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"获取今日签到失败" afterHideTime:DELAYTiME];
    }];
}
//今日签到
- (void)getSignNow {
    WEAKSELF
    NSDictionary *dic = @{@"userId":self.userId};
    [ENDNetWorkManager postWithPathUrl:@"/user/sign/signNow" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        
        
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"签到失败" afterHideTime:DELAYTiME];
    }];
}
//签到历史
- (void)getSignList {
    WEAKSELF
    NSDictionary *dic = @{@"userId":self.userId};
    [ENDNetWorkManager getWithPathUrl:@"/user/sign/getSignList" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        
        NSError *error;
        weakSelf.signedArray = [MTLJSONAdapter modelsOfClass:[SignModel class] fromJSONArray:result[@"data"] error:&error];
        for (SignModel *signModel in weakSelf.signedArray) {
            //时间戳转NSDate
            NSDate *signedDate = [NSDate dateWithTimeIntervalSince1970:signModel.time/1000];
            //得到的日子设置为选中
            [weakSelf.calendar selectDate:signedDate];
        }
        weakSelf.dataModel = weakSelf.signedArray.lastObject;
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"获取签到历史失败" afterHideTime:DELAYTiME];
    }];
}
@end
