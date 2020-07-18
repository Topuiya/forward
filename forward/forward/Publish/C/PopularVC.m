//
//  PopularVC.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "PopularVC.h"
#import "ShowNewsTableCell.h"
#import "HomeNewsModel.h"
#import "DetailVC.h"
#import <SVProgressHUD.h>
#import "PublishTopicVC.h"

@interface PopularVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *newsArray;
@end

@implementation PopularVC

NSString *PopShowNewsID = @"ShowNewsTableCell";
- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShowNewsTableCell class]) bundle:nil] forCellReuseIdentifier:PopShowNewsID];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:PopShowNewsID forIndexPath:indexPath];
    cell.newsModel = self.newsArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailVC *vc = DetailVC.new;
    vc.newsModel = self.newsArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:API
-(void)getTopics{
    [SVProgressHUD show];
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/user/talk/getRecommandTalk" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.newsArray = [MTLJSONAdapter modelsOfClass:[HomeNewsModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(BOOL failuer, NSError *error) {
        [SVProgressHUD dismiss];
        [Toast makeText:weakSelf.view Message:@"请求热门资讯失败" afterHideTime:DELAYTiME];
    }];
}

@end
