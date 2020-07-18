//
//  MyFollowVC.m
//  forward
//
//  Created by apple on 2020/7/10.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "MyFollowVC.h"
#import "MyFollowTableCell.h"
#import "MyFollowModel.h"
#import "UserModel.h"

@interface MyFollowVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *followArray;
@end

@implementation MyFollowVC
NSString *MyFollowID = @"MyFollowTableCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.hbd_barTintColor = UIColor.whiteColor;
    //隐藏导航栏下面的阴影
    self.hbd_barShadowHidden = YES;
    self.hbd_tintColor = [UIColor colorWithHexString:@"333333"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyFollowTableCell class]) bundle:nil] forCellReuseIdentifier:MyFollowID];
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    [self getFollowList];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _followArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFollowTableCell *cell = [tableView dequeueReusableCellWithIdentifier:MyFollowID];
    cell.followModel = _followArray[indexPath.row];
    return cell;
}
#pragma mark  - FollowList
//获取关注列表
- (void)getFollowList {
    WEAKSELF
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSDictionary *dic = @{@"userId":user.userId,
                          @"type":@1};
    [ENDNetWorkManager getWithPathUrl:@"/user/follow/getUserFollowList" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.followArray = [MTLJSONAdapter modelsOfClass:[MyFollowModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        [weakSelf.tableView reloadData];
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"请求关注列表失败" afterHideTime:DELAYTiME];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

@end
