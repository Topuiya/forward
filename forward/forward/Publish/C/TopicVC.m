//
//  TopicVC.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "TopicVC.h"
#import "HotTopicTableCell.h"
#import "TopicHeadView.h"
#import "TopicFootView.h"

@interface TopicVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TopicVC

NSString *HotTopicID = @"HotTopicTableCell";
- (void)viewDidLoad {
    //隐藏导航栏下面的阴影
    self.hbd_barShadowHidden = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotTopicTableCell class]) bundle:nil] forCellReuseIdentifier:HotTopicID];
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
    HotTopicTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HotTopicID];
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    TopicHeadView *headView = TopicHeadView.new;
//    return headView;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    TopicFootView *footView = TopicFootView.new;
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80;
}

@end
