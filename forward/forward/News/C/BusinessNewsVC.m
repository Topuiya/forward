//
//  BusinessNewsVC.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "BusinessNewsVC.h"
#import "BusinessNewsTableCell.h"
#import "SearchHeadView.h"
#import "BusinessNewsModel.h"

@interface BusinessNewsVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *businessArray;
@end

@implementation BusinessNewsVC

NSString *BusinessNewsTableID = @"BusinessNewsTableCell";
- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BusinessNewsTableCell class]) bundle:nil] forCellReuseIdentifier:BusinessNewsTableID];
}

- (UIView *)listView {
    return self.view;
}

- (void)viewWillAppear:(BOOL)animated {
    [self getBusinessData];
}

-(void)getBusinessData{
    WEAKSELF
    NSDate *todayDate = [NSDate date];
    NSDictionary *dic = @{@"date":todayDate};
    [ENDNetWorkManager getWithPathUrl:@"/admin/getFinanceAffairs" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.businessArray = [MTLJSONAdapter modelsOfClass:[BusinessNewsModel class] fromJSONArray:result[@"data"] error:&error];
        [weakSelf.tableView reloadData];
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"请求话题失败" afterHideTime:DELAYTiME];
    }];
}


#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _businessArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:BusinessNewsTableID forIndexPath:indexPath];
    cell.businessModel = self.businessArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SearchHeadView *headView = [[SearchHeadView alloc] init];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

@end
