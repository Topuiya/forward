//
//  DetailVC.m
//  forward
//
//  Created by apple on 2020/7/8.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "DetailVC.h"
#import "DetailHeadTableCell.h"
#import "DetailTableCell.h"
#import "CommentModel.h"
#import "RecommandTalkModel.h"
#import "UserModel.h"

@interface DetailVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) RecommandTalkModel *talkModel;
@property (weak, nonatomic) IBOutlet UITextField *commentTextF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (strong, nonatomic) NSArray<CommentModel *> *commentArray;
@property (assign, nonatomic) BOOL isMine;
@end

@implementation DetailVC
NSString *DetailHeadCellID = @"DetailHeadTableCell";
NSString *DetailCellID = @"DetailTableCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    if (kIsIPhoneX_Series) {
        _bottomViewHeight.constant = 60;
    }else {
        _bottomViewHeight.constant = 50;
    }
    self.hbd_barTintColor = UIColor.whiteColor;
    //隐藏导航栏下面的阴影
    self.hbd_barShadowHidden = YES;
    self.hbd_tintColor = UIColor.blackColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailHeadTableCell class]) bundle:nil] forCellReuseIdentifier:DetailHeadCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailTableCell class]) bundle:nil] forCellReuseIdentifier:DetailCellID];
    [self setMJRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    if ([log isEqualToNumber:@1]) {
        [self getCommentData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _commentArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DetailHeadTableCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailHeadCellID];
        cell.newsModel = _newsModel;
        return cell;
    } else {
        DetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
        cell.commentModel = self.commentArray[indexPath.row];
//        cell.commentModel = _newsModel;
        return cell;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        headView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 10)];
        title.textColor = [UIColor colorWithHexString:@"#666666"];
        title.font = [UIFont systemFontOfSize:15];
        title.text = @"全部评论";
        [headView addSubview:title];
        return headView;
    } else {
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    } else
        return 30;
}
- (IBAction)sendBtnClick:(id)sender {
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    if ([log isEqualToNumber:@1]) {
        [self postComment];
        [self.commentTextF resignFirstResponder];
        self.commentTextF.text = @"";
    }
    else if (_commentTextF.text.length > 9) {
        [Toast makeText:self.view Message:@"评论长度不能小于9个字符" afterHideTime:DELAYTiME];
    }
}
-(void)setMJRefresh{
    //上拉加载
    WEAKSELF
    weakSelf.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getCommentData];
    }];
}

#pragma mark - 获取接口数据
-(void)getCommentData{
    NSDictionary *dict =  @{@"_orderByDesc":@"publishTime",@"talkId":_newsModel.talkId};
    WEAKSELF
    [ENDNetWorkManager postWithPathUrl:@"/user/talk/getCommentList" parameters:dict queryParams:nil Header:nil success:^(BOOL success, id result) {
        NSError *error;
        weakSelf.commentArray = [MTLJSONAdapter modelsOfClass:[CommentModel class] fromJSONArray:result[@"data"][@"list"] error:&error];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
    } failure:^(BOOL failuer, NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [Toast makeText:weakSelf.view Message:@"获取评论失败" afterHideTime:DELAYTiME];
    }];
}

-(void)postComment{
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSDictionary *dict = @{ @"userId" : user.userId,
                            @"talkId" : _newsModel.talkId,
                            @"content" : self.commentTextF.text,
    };
    WEAKSELF
    [ENDNetWorkManager postWithPathUrl:@"/user/talk/commentTalk" parameters:nil queryParams:dict Header:nil success:^(BOOL success, id result) {
        [weakSelf getCommentData];
        [Toast makeText:self.view Message:@"评论成功" afterHideTime:DELAYTiME];
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:self.view Message:@"评论失败,请稍后再试" afterHideTime:DELAYTiME];
    }];
}
@end
