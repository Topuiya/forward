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

@interface HomeVC () <UITableViewDelegate,UITableViewDataSource,HomeHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;

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
    
}

- (void)viewWillAppear:(BOOL)animated {
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
}
- (void)viewWillDisappear:(BOOL)animated {
    self.hbd_barHidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
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
        return 10;
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        HomeQuotesTableCell *cell = [tableView dequeueReusableCellWithIdentifier:QuotesTableCellID];
        return cell;
    }
    else {
        HotNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HotNewsTableCellID];
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

#pragma mark - HomeHeaderViewDelegate

//日历数据
- (void)didSelectedCarlendarView {
    CalendarVC *vc = CalendarVC.new;
//    vc.tabBarController.tabBar.hidden = YES;
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
