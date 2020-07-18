//
//  MineVC.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "MineVC.h"
#import "UIImage+OriginalImage.h"
#import "MineItemTableCell.h"
#import "MineInfoTableCell.h"
#import "MineOutTableCell.h"
#import "MineTitleModel.h"
#import "RegisterVC.h"
#import "LoginVC.h"
#import "UserModel.h"
#import "MyFollowVC.h"
#import "MyFansVC.h"
#import "SignInVC.h"
#import "FeedbackVC.h"
#import "MyInfoVC.h"

@interface MineVC () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconTopConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
//TopView属性
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionLaebl;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
//签到按钮
@property (weak, nonatomic) IBOutlet UIView *signinBtn;

@property (strong, nonatomic) NSNumber *followCount;
@property (strong, nonatomic) NSNumber *fansCount;

//关注和粉丝view
@property (weak, nonatomic) IBOutlet UIView *attentionView;
@property (weak, nonatomic) IBOutlet UIView *fansView;
//签到View
@property (weak, nonatomic) IBOutlet UIView *signInView;

@end

@implementation MineVC

- (NSArray *)titleArray {
    if (_titleArray == nil) {
        MineTitleModel *model1 = MineTitleModel.new;
        model1.titleStr = @"个人信息";
        
        MineTitleModel *tempModel = MineTitleModel.new;
        tempModel.titleStr = @"消息推送";
        
        MineTitleModel *model2 = MineTitleModel.new;
        model2.titleStr = @"清除缓存";
        model2.detailStr = @"0.0M";
        
        MineTitleModel *model3 = MineTitleModel.new;
        model3.titleStr = @"服务协议";
        
        MineTitleModel *model4 = MineTitleModel.new;
        model4.titleStr = @"意见反馈";
        
        MineTitleModel *model5 = MineTitleModel.new;
        model5.titleStr = @"关于我们";
        
        NSMutableArray *temp = NSMutableArray.new;
        [temp addObject:model1];
        [temp addObject:tempModel];
        [temp addObject:model2];
        [temp addObject:model3];
        [temp addObject:model4];
        [temp addObject:model5];
        _titleArray = temp;
    }
    return _titleArray;
}

NSString *MineItemID = @"MineItemTableCell";
NSString *MineInfoID = @"MineInfoTableCell";
NSString *MineOutID = @"MineOutTableCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    if (kIsIPhoneX_Series) {
        self.iconTopConstraint.constant = 90;
    }else
        self.iconTopConstraint.constant = 66;
    self.title = @"个人中心";
    self.hbd_barAlpha = 0;
    //导航栏标题和状态栏颜色:白
    self.hbd_blackBarStyle = YES;
    //右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"icon_xiaoxizhongxin"] style:UIBarButtonItemStyleDone target:self action:@selector(infoBtnClick)];
    
    [self loadTableView];
    
    [self addIconImageViewTouch];
    
    //关注和粉丝view添加点击事件
    self.attentionView.userInteractionEnabled = YES;
    UITapGestureRecognizer *attentionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedAttentionView)];
    [self.attentionView addGestureRecognizer:attentionTap];
    self.fansView.userInteractionEnabled = YES;
    UITapGestureRecognizer *fansTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedFansTapView)];
    [self.fansView addGestureRecognizer:fansTap];
    
    self.signInView.userInteractionEnabled = YES;
    UITapGestureRecognizer *signTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedSignInView)];
    [self.signInView addGestureRecognizer:signTap];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    [self uploginData:user.phone password:user.pwd];
    //获取关注和粉丝总数
    if (user.userId != nil) {
        [self getFollowCount:user.userId];
        [self getFansCount:user.userId];
    }
    
}
- (void)infoBtnClick {
    
}
- (void)selectedAttentionView {
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    if ([log  isEqual: @1]) {
        MyFollowVC *vc = MyFollowVC.new;
        vc.titleStr = @"我的关注";
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        LoginVC *vc = LoginVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)selectedFansTapView {
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    if ([log  isEqual: @1]) {
        MyFansVC *vc = MyFansVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        LoginVC *vc = LoginVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)selectedSignInView {
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    if ([log  isEqual: @1]) {
        SignInVC *vc = SignInVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        LoginVC *vc = LoginVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)setTopViewData {
    //取出本地的数据
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    if ([log  isEqual: @1]) {
        NSURL *picURL = [NSURL URLWithString:user.head];
        [self.iconImageView sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"denglutouxiang"]];
        self.nickNameLabel.text = user.nickName;
        self.fansLabel.text = user.fansCount.description;
        
        if (self.followCount.description == nil) {
            self.attentionLaebl.text = @"0";
        } else {
            self.attentionLaebl.text = self.followCount.description;
        }
        if (self.fansCount.description == nil) {
            self.fansLabel.text = @"0";
        } else {
            self.fansLabel.text = self.fansCount.description;
        }
        
    }
    else {
        self.iconImageView.image = [UIImage imageNamed:@"denglutouxiang"];
        self.nickNameLabel.text = @"注册/登录";
        self.historyLabel.text = @"0";
        self.fansLabel.text = @"0";
        self.attentionLaebl.text = @"0";
    }
}

//头像点击
- (void)addIconImageViewTouch {
    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *iconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectedIconImageView)];
    [self.iconImageView addGestureRecognizer:iconTap];
    
}
- (void)didSelectedIconImageView {
    LoginVC *loginVC = LoginVC.new;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)loadTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MineItemTableCell class]) bundle:nil] forCellReuseIdentifier:MineItemID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MineInfoTableCell class]) bundle:nil] forCellReuseIdentifier:MineInfoID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MineOutTableCell class]) bundle:nil] forCellReuseIdentifier:MineOutID];
}


#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 1;
    } else
        return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        MineInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:MineInfoID forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 2) {
        MineOutTableCell *cell = [tableView dequeueReusableCellWithIdentifier:MineOutID forIndexPath:indexPath];
        WEAKSELF
        cell.didClickOutButtonBlock = ^{
            //退出登录
            //取出本地的数据
            NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
            log = @0;
            [EGHCodeTool archiveOJBC:log saveKey:isLog];
            [weakSelf setTopViewData];
        };
        return cell;
    }
    else {
        MineItemTableCell *cell = [tableView dequeueReusableCellWithIdentifier:MineItemID forIndexPath:indexPath];
        if(indexPath.section == 0)
            cell.model = self.titleArray[indexPath.row];
        else if(indexPath.section == 1)
            cell.model = self.titleArray[indexPath.row + 3];
        return cell;
    }
}

#pragma mark  - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    } else
        return 10;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor colorWithHexString:@"#F3F2F4"];
    return headView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        MyInfoVC *vc = MyInfoVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        FeedbackVC *vc = FeedbackVC.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//使用密码登录
- (void)uploginData:(NSString *)phone password:(NSString *)pwd
{
    WEAKSELF
    NSDictionary *dic = @{@"phone":phone,
                          @"password":pwd,
                          @"type":@(1),
                          @"project":ProjectCategory};
    [ENDNetWorkManager getWithPathUrl:@"/system/login" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        UserModel *user = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:result[@"data"] error:&error];
        //登录之后归档数据
        [EGHCodeTool archiveOJBC:user saveKey:userModel];
        NSNumber *islog = @1;
        [EGHCodeTool archiveOJBC:islog saveKey:isLog];
        [weakSelf setTopViewData];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:weakSelf.view Message:@"登录失败" afterHideTime:DELAYTiME];
    }];
}

#pragma mark  - 关注
/*获取用户关注/粉丝列表总数*/
- (void)getFollowCount:(NSNumber *)userId {
    WEAKSELF
    //type: 1-用户关注总数 2-用户粉丝总数
    NSDictionary *dic = @{@"userId":userId,
                              @"type":@(1)};
    [ENDNetWorkManager getWithPathUrl:@"/user/follow/getUserFollowCount" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        weakSelf.followCount = result[@"data"];
        [weakSelf setTopViewData];
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"获取关注总数失败" afterHideTime:DELAYTiME];
    }];
}
//获取粉丝列表总数
- (void)getFansCount:(NSNumber *)userId {
    WEAKSELF
    //type: 1-用户关注总数 2-用户粉丝总数
    NSDictionary *dic = @{@"userId":userId,
                              @"type":@(2)};
    [ENDNetWorkManager getWithPathUrl:@"/user/follow/getUserFollowCount" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        weakSelf.fansCount = result[@"data"];
        [weakSelf setTopViewData];
    } failure:^(BOOL failuer, NSError *error) {
        [Toast makeText:weakSelf.view Message:@"获取粉丝总数失败" afterHideTime:DELAYTiME];
    }];
}
@end
