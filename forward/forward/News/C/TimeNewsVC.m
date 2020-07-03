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

@interface TimeNewsVC () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) double yCell;
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

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TimeNewsTopTableCell *cell = [tableView dequeueReusableCellWithIdentifier:TimeNewsTopID];
        return cell;
    } else {
        TimeNewsDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:TimeNewsDetailID];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TimeNewsHeadView *headView = [[TimeNewsHeadView alloc] init];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
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
