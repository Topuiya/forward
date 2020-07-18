//
//  HomeVC.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "HomeVC.h"
#import "HomeHeaderView.h"
#import "HomeTitleView.h"
#import "HomeQuotesTableCell.h"
#import "HotNewsTableCell.h"
#import "CalendarVC.h"
#import "HomeNewsModel.h"
#import "DetailVC.h"
#import "QuoteCalendarModel.h"
#import "SignInVC.h"
#import "LoginVC.h"
#import "CZ_NEWMarketVC.h"
#import "BusinessNewsVC.h"
#import "TimeNewsVC.h"
#import <SVProgressHUD.h>
#import "NetWork.h"
#import <MJRefresh.h>

@interface HomeVC () <UITableViewDelegate,UITableViewDataSource,HomeHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;
@property (nonatomic, strong) NSArray *newsArray;
@property (nonatomic, strong) NSMutableArray *newsMutableArray;
@property (nonatomic, strong) NSArray *calendarArray;
@property (nonatomic, strong)NSArray *quotesArray;
@property (nonatomic, assign)NSInteger pageNumber;
@end

@implementation HomeVC

NSString *QuotesTableCellID = @"HomeQuotesTableCell";
NSString *HotNewsTableCellID = @"HotNewsTableCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeQuotesTableCell class]) bundle:nil] forCellReuseIdentifier:QuotesTableCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotNewsTableCell class]) bundle:nil] forCellReuseIdentifier:HotNewsTableCellID];
    [self setMJRefresh];
    [self getMJRefresh];
    _pageNumber = 1;
    self.newsMutableArray = [NSMutableArray array];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"首页";
    //隐藏导航栏
    self.hbd_barHidden = YES;
    
    if (kIsIPhoneX_Series) {
        self.tableViewTop.constant = -44;
    }
    else {
        self.tableViewTop.constant = -20;
    }
    self.tabBarController.tabBar.hidden = NO;
    [SVProgressHUD show];
    [self getTopics];
    [self getCanlendar];
    [self regetData:@"http://data.api51.cn/apis/integration/rank/?market_type=cryptocurrency&limit=13&order_by=desc&fields=prod_name%2Cprod_code%2Clast_px%2Cpx_change%2Cpx_change_rate%2Chigh_px%2Clow_px%2Cupdate_time&token=3f39051e89e1cea0a84da126601763d8"];
}
#pragma mark -下拉加载
-(void)getMJRefresh{
    //下拉加载
    WEAKSELF
    weakSelf.pageNumber ++;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getTopics];
    }];
}
-(void)setMJRefresh{
    WEAKSELF
    weakSelf.pageNumber ++;
    weakSelf.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getTopics];
    }];
}
#pragma mark - UITableViewViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0;
    }
    else if (section == 3)
        return self.newsArray.count;
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        HomeQuotesTableCell *cell = [tableView dequeueReusableCellWithIdentifier:QuotesTableCellID];
        cell.quotesArray = _quotesArray;
        return cell;
    }
    else {
        HotNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HotNewsTableCellID];
        cell.newsModel = self.newsArray[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 100;
    } else
        return UITableViewAutomaticDimension;;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        HomeHeaderView *headView = [[HomeHeaderView alloc] init];
        headView.delegate = self;
        return headView;
    }
    else if (section == 1) {
        UIView *headView = UIView.new;
        headView.frame = CGRectMake(0, 0, 0, 80);
        UIImageView *signImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_qiandao"]];
        signImageView.frame = CGRectMake(SCREEN_WIDTH/2 -160 , 10, 320, 90);
        if (kIsIPhoneX_Series) {
            signImageView.frame = CGRectMake(SCREEN_WIDTH/2 -160 , 10, 320, 90);
        }else {
            signImageView.frame = CGRectMake(SCREEN_WIDTH/2 -160 , -10, 320, 90);
        }
        headView.userInteractionEnabled = YES;
        UITapGestureRecognizer *signTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedHeadView)];
        [headView addGestureRecognizer:signTap];
        [headView addSubview:signImageView];
        return headView;
    }
    else if (section == 2) {
        HomeTitleView *headTitleView = [[HomeTitleView alloc] init];
        return headTitleView;
    }
    else {
        HomeTitleView *headTitleView = [[HomeTitleView alloc] init];
        headTitleView.titleLabel.text = @"热门资讯";
        return headTitleView;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 340;
    }
    else if (section == 1) {
        return 90;
    }
    else {
        return 20;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        DetailVC *detailVC = DetailVC.new;
        detailVC.newsModel = _newsArray[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)selectedHeadView {
    //判断用户是否登录
    //取出本地的数据
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    if ([log  isEqual: @1]) {
        SignInVC *vc = SignInVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        LoginVC *vc = LoginVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)getTopics{
    WEAKSELF
    NSDictionary *dict = @{@"pageNumber":@(_pageNumber)};
    [ENDNetWorkManager getWithPathUrl:@"/user/talk/getRecommandTalk" parameters:nil queryParams:dict Header:nil success:^(BOOL success, id result) {
        NSError *error;
        [SVProgressHUD dismiss];
        weakSelf.newsArray = [MTLJSONAdapter modelsOfClass:[HomeNewsModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        [weakSelf.newsMutableArray addObjectsFromArray:weakSelf.newsArray];
        weakSelf.newsArray = weakSelf.newsMutableArray;
        //刷新第3个section
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
        BOOL hasMore = result[@"data"][@"hasMore"];
        if (hasMore) {
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView.mj_header endRefreshing];
        }
        else{
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [SVProgressHUD dismiss];
        weakSelf.pageNumber --;
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView.mj_header endRefreshing];
        [Toast makeText:weakSelf.view Message:@"请求热门资讯失败" afterHideTime:DELAYTiME];
    }];
}
//请求日历数据
- (void)getCanlendar {
    WEAKSELF
    NSDate *todayDate = [NSDate date];
    NSDictionary *dic = @{@"date":todayDate};
    [ENDNetWorkManager getWithPathUrl:@"/admin/getFinanceCalender" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.calendarArray = [MTLJSONAdapter modelsOfClass:[QuoteCalendarModel class] fromJSONArray:result[@"data"] error:&error];
        
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"请求失败" afterHideTime:DELAYTiME];
    }];
}
//数字货币
-(void)regetData:(NSString *)URLStr{
    WEAKSELF
    //数字货币=@"http://data.api51.cn/apis/integration/rank/?market_type=cryptocurrency&limit=13&order_by=desc&fields=prod_name%2Cprod_code%2Clast_px%2Cpx_change%2Cpx_change_rate%2Chigh_px%2Clow_px%2Cupdate_time&token=3f39051e89e1cea0a84da126601763d8"
    
    [NetWork requestGet:URLStr Success:^(NSDictionary * _Nonnull dic) {
        
        NSDictionary *dataD = [dic objectForKey:@"data"];
        
        weakSelf.quotesArray = [NSArray arrayWithArray:(NSArray *)dataD[@"candle"]];
        
        if (weakSelf.quotesArray.count == 0) {
            [Toast makeText:self.view Message:@"请求失败，请刷新重试" afterHideTime:DELAYTiME];
            return;
        }
        [weakSelf.tableView reloadData];
    } ERROR:^(NSError * _Nonnull error) {
    }];
}

#pragma mark - HomeHeaderViewDelegate
//行情中心
- (void)didSelectedQuotesView {
    CZ_NEWMarketVC *vc = CZ_NEWMarketVC.new;
    vc.hbd_tintColor = [UIColor colorWithHexString:@"333333"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//日历数据
- (void)didSelectedCarlendarView {
    CalendarVC *vc = CalendarVC.new;
    vc.dataArray = self.calendarArray;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didSelectedBusinessNewsView {
    BusinessNewsVC *vc = BusinessNewsVC.new;
    vc.title = @"行业风暴";
    vc.hidesBottomBarWhenPushed = YES;
    vc.hbd_tintColor = [UIColor colorWithHexString:@"333333"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didSelectedTimeNewsView {
    TimeNewsVC *vc = TimeNewsVC.new;
    vc.title = @"7x24快讯";
    vc.hidesBottomBarWhenPushed = YES;
    vc.hbd_tintColor = [UIColor colorWithHexString:@"333333"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
