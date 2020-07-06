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

@interface MineVC () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconTopConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
//签到按钮
@property (weak, nonatomic) IBOutlet UIView *signinBtn;

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
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}
- (void)infoBtnClick {
    
}

//头像点击
- (void)addIconImageViewTouch {
    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *iconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectedIconImageView)];
    [self.iconImageView addGestureRecognizer:iconTap];
    
}
- (void)didSelectedIconImageView {
//    RegisterVC *registerVC = RegisterVC.new;
//    [self presentViewController:registerVC animated:YES completion:^{
//    }];
    
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

@end
