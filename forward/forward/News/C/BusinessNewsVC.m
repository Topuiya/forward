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

@interface BusinessNewsVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:BusinessNewsTableID forIndexPath:indexPath];
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
