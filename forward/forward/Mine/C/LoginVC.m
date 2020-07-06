//
//  LoginVC.m
//  forward
//
//  Created by apple on 2020/7/6.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "LoginVC.h"
#import "JXCategoryTitleView.h"
#import "PwdLoginVC.h"
#import "OtherLoginVC.h"

@interface LoginVC ()

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hbd_barTintColor = UIColor.whiteColor;
    //隐藏导航栏下面的阴影
    self.hbd_barShadowHidden = YES;
    self.hbd_tintColor = UIColor.blackColor;
    
    self.titles = @[@"密码登录", @"免密登录", ];
    CGFloat cellWid = 160;
    self.myCategoryView.frame = CGRectMake(0, 0, cellWid, 30);
    self.myCategoryView.layer.cornerRadius = 15;
    self.myCategoryView.layer.masksToBounds = YES;
    self.myCategoryView.layer.borderColor = [UIColor colorWithHexString:@"#F1B5B1"].CGColor;
    self.myCategoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;;
    self.myCategoryView.backgroundColor = [UIColor colorWithHexString:@"#F1B5B1"];
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.cellWidth = cellWid/2;
    self.myCategoryView.titleColor = [UIColor whiteColor];
    self.myCategoryView.titleSelectedColor = [UIColor colorWithHexString:@"#333333"];
    self.myCategoryView.titleLabelMaskEnabled = YES;

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 30;
    backgroundView.indicatorWidthIncrement = 0;
    backgroundView.indicatorColor = [UIColor whiteColor];
    self.myCategoryView.indicators = @[backgroundView];

    [self.myCategoryView removeFromSuperview];
    self.navigationItem.titleView = self.myCategoryView;
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.myCategoryView.frame = CGRectMake(0, 0, 160, 30);
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 0;
}

-(NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return  2;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0)
    {
        PwdLoginVC *loginVC = [[PwdLoginVC alloc]init];
        //拿到要使用的模型数组
//        RankTeamListModel *tempModel = _teamListArray[0];
        //对改数组排序
//        NSArray *wzryArray = [self mySortArray:tempModel.list];
//        tempModel.list = wzryArray;
        //传递模型
//        wzryVC.WzryModel = tempModel;
        return loginVC;
    }
    else
    {
        OtherLoginVC *loginVC = [[OtherLoginVC alloc]init];
        return loginVC;
    }
}

@end
