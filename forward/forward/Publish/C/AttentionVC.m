//
//  AttentionVC.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "AttentionVC.h"
//#import "ShowNewsTableCell.h"
#import "AttentionHeadView.h"
#import "AttentionTableCell.h"
#import "HomeNewsModel.h"
#import "AttentionNewsTableCell.h"

@interface AttentionVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *newsArray;
//推荐关注数组
@property (nonatomic, strong) NSArray *recommendArray;
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
    if ([_log  isEqual: @1]) {
        [self getRecommendUsers];
    }
    
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
    } else {
        return _newsArray.count;
    }
        
//        return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        AttentionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:AttentionTableID forIndexPath:indexPath];
        cell.modelArray = _recommendArray;
        return cell;
    }
    else {
        AttentionNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:AttentionShowID forIndexPath:indexPath];
        cell.attentionModel = self.newsArray[indexPath.row];
//        UITableViewCell *cell = UITableViewCell.new;
        return cell;
    }
    return nil;
    
}

//MARK:API
-(void)getTopics{
    WEAKSELF
    [ENDNetWorkManager getWithPathUrl:@"/user/talk/getRecommandTalk" parameters:nil queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.newsArray = [MTLJSONAdapter modelsOfClass:[HomeNewsModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        //刷新
//        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf.tableView reloadData];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"请求热门资讯失败" afterHideTime:DELAYTiME];
    }];
}
//获取推荐关注列表
-(void)getRecommendUsers{
    WEAKSELF
    //推荐用户清单接口
    NSDictionary *dic = @{@"userId":self.userId};
    [ENDNetWorkManager getWithPathUrl:@"/user/follow/getRecommandUserList" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        //将拿到的结果传递给数组
        weakSelf.recommendArray = [MTLJSONAdapter modelsOfClass:[UserModel class] fromJSONArray:result[@"data"] error:&error];
        //刷新第一个section
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:self.view Message:@"请求推荐关注失败" afterHideTime:DELAYTiME];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    }
    else
        return UITableViewAutomaticDimension;
}

@end
