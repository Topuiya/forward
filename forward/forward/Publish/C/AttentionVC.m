//
//  AttentionVC.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "AttentionVC.h"
#import "ShowNewsTableCell.h"
#import "AttentionHeadView.h"

@interface AttentionVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AttentionVC

NSString *AttentionShowID = @"AttentionShowTableCell";
- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShowNewsTableCell class]) bundle:nil] forCellReuseIdentifier:AttentionShowID];
}
- (UIView *)listView {
    return self.view;
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else
        return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:AttentionShowID forIndexPath:indexPath];
    return cell;
}

#pragma mark  - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AttentionHeadView *headView = AttentionHeadView.new;
    if (section == 1) {
        headView.titleLabel.text = @"热门动态";
        headView.moreBtn.hidden = YES;
    }
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
@end
