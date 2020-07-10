//
//  MyFansVC.m
//  forward
//
//  Created by apple on 2020/7/10.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "MyFansVC.h"
#import "MyFollowModel.h"
#import "UserModel.h"
#import "MyFansTableCell.h"

@interface MyFansVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *fansArray;
@end

@implementation MyFansVC
NSString *MyFansID = @"MyFansTableCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的粉丝";
    self.hbd_barTintColor = UIColor.whiteColor;
    //隐藏导航栏下面的阴影
    self.hbd_barShadowHidden = YES;
    self.hbd_tintColor = [UIColor colorWithHexString:@"333333"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyFansTableCell class]) bundle:nil] forCellReuseIdentifier:MyFansID];
}
- (void)viewWillAppear:(BOOL)animated {
    [self getFansList];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _fansArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFansTableCell *cell = [tableView dequeueReusableCellWithIdentifier:MyFansID];
    cell.fansModel = _fansArray[indexPath.row];
    return cell;
}
//获取粉丝列表
- (void)getFansList {
    WEAKSELF
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSDictionary *dic = @{@"userId":user.userId,
                          @"type":@2};
    [ENDNetWorkManager getWithPathUrl:@"/user/follow/getUserFollowList" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.fansArray = [MTLJSONAdapter modelsOfClass:[MyFollowModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        [weakSelf.tableView reloadData];
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"请求粉丝列表失败" afterHideTime:DELAYTiME];
    }];
}
@end
