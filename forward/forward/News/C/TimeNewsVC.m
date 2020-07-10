//
//  TimeNewsVC.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "TimeNewsVC.h"
#import "TimeNewsHeadView.h"
#import "TimeNewsTopTableCell.h"
#import "TimeNewsDetailTableCell.h"
#import "TimeNewsModel.h"

@interface TimeNewsVC () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) double yCell;
@property (nonatomic, strong) NSArray *timeNewsArray;
@end

@implementation TimeNewsVC

NSString *TimeNewsTopID = @"TimeNewsTopTableCell";
NSString *TimeNewsDetailID = @"TimeNewsDetailTableCell";
- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TimeNewsTopTableCell class]) bundle:nil] forCellReuseIdentifier:TimeNewsTopID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TimeNewsDetailTableCell class]) bundle:nil] forCellReuseIdentifier:TimeNewsDetailID];
}

- (UIView *)listView {
    return self.view;
}

- (void)viewWillAppear:(BOOL)animated {
    [self getTopics];
}

-(void)getTopics{
    WEAKSELF
    NSDate *todayDate = [NSDate date];
    NSDictionary *dic = @{@"date":todayDate};
    [ENDNetWorkManager getWithPathUrl:@"/admin/getFinanceTalk" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.timeNewsArray = [MTLJSONAdapter modelsOfClass:[TimeNewsModel class] fromJSONArray:result[@"data"] error:&error];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"请求话题失败" afterHideTime:DELAYTiME];
    }];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _timeNewsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0 && indexPath.row == 0) {
        TimeNewsTopTableCell *cell = [tableView dequeueReusableCellWithIdentifier:TimeNewsTopID];
        return cell;
    } else {
        TimeNewsDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:TimeNewsDetailID];
        cell.timeNewsModel = self.timeNewsArray[indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        TimeNewsHeadView *headView = [[TimeNewsHeadView alloc] init];
        return headView;
    }
    else
        return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 45;
    } else
        return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.y >= 0) {
        self.yCell = offset.y;
    }
}

@end
