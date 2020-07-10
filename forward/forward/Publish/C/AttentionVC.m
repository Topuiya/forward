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
#import "AttentionTableCell.h"
#import "HomeNewsModel.h"

@interface AttentionVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *newsArray;
@end

@implementation AttentionVC

NSString *AttentionShowID = @"AttentionShowTableCell";
NSString *AttentionTableID = @"AttentionTableCell";
- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShowNewsTableCell class]) bundle:nil] forCellReuseIdentifier:AttentionShowID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AttentionTableCell class]) bundle:nil] forCellReuseIdentifier:AttentionTableID];
}
- (UIView *)listView {
    return self.view;
}
- (void)viewWillAppear:(BOOL)animated {
    [self getTopics];
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
    if (indexPath.section == 0) {
        AttentionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:AttentionTableID forIndexPath:indexPath];
        return cell;
    }
    else {
        ShowNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:AttentionShowID forIndexPath:indexPath];
        cell.newsModel = self.newsArray[indexPath.row];
        return cell;
    }
}


-(void)getTopics{
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/user/talk/getRecommandTalk" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.newsArray = [MTLJSONAdapter modelsOfClass:[HomeNewsModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求热门资讯失败" afterHideTime:DELAYTiME];
    }];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    }
    else
        return UITableViewAutomaticDimension;
}

@end
