//
//  AttentionVC.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "AttentionVC.h"
#import "AttentionHeadView.h"
#import "AttentionTableCell.h"
#import "HomeNewsModel.h"
#import "AttentionNewsTableCell.h"
#import "DetailVC.h"
#import <SVProgressHUD.h>
#import "PublishTopicVC.h"

@interface AttentionVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *newsArray;

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *log;
@end

@implementation AttentionVC

NSString *AttentionShowID = @"AttentionShowTableCell";
NSString *AttentionTableID = @"AttentionTableCell";
- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AttentionNewsTableCell class]) bundle:nil] forCellReuseIdentifier:AttentionShowID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AttentionTableCell class]) bundle:nil] forCellReuseIdentifier:AttentionTableID];
    
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    self.userId = user.userId;
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    self.log = log;
}
- (UIView *)listView {
    return self.view;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [self getTopics];
}
- (IBAction)publishBtnClick:(id)sender {
    PublishTopicVC *topicVC = PublishTopicVC.new;
    [self.navigationController pushViewController:topicVC animated:YES];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _newsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        AttentionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:AttentionTableID forIndexPath:indexPath];
        return cell;
    }
    else {
        AttentionNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:AttentionShowID forIndexPath:indexPath];
        cell.attentionModel = self.newsArray[indexPath.row];
        return cell;
    }
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        DetailVC *vc = DetailVC.new;
        vc.newsModel = self.newsArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//MARK:API
-(void)getTopics{
    [SVProgressHUD show];
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/user/talk/getRecommandTalk" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.newsArray = [MTLJSONAdapter modelsOfClass:[HomeNewsModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        //刷新
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(BOOL failuer, NSError *error) {
        [SVProgressHUD dismiss];
        [Toast makeText:weakSelf.view Message:@"请求热门资讯失败" afterHideTime:DELAYTiME];
    }];
}

#pragma mark  - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AttentionHeadView *headView = AttentionHeadView.new;
    headView.moreBtn.hidden = YES;
    if (section == 1) {
        headView.titleLabel.text = @"热门动态";
//        headView.moreBtn.hidden = YES;
    }
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
    
}

@end
