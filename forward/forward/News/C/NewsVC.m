//
//  NewsVC.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "NewsVC.h"
#import "BusinessNewsVC.h"
#import "TimeNewsVC.h"
#import "JXCategoryTitleView.h"

@interface NewsVC ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hbd_barTintColor = UIColor.clearColor;
    //隐藏导航栏下面的阴影
    self.hbd_barShadowHidden = YES;
    self.titles = @[@"行业风暴", @"7x24快讯",];
    self.myCategoryView.titles = self.titles;
    
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)self.myCategoryView;
    titleCategoryView.titleColor = [UIColor colorWithHexString:@"#666666"];
    titleCategoryView.titleSelectedColor = [UIColor colorWithHexString:@"#333333"];
    self.isNeedIndicatorPositionChangeItem = YES;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.3;
    titleCategoryView.titleLabelStrokeWidthEnabled = YES;
    titleCategoryView.selectedAnimationEnabled = YES;
    
    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.componentPosition = JXCategoryComponentPosition_Bottom;
    backgroundView.indicatorHeight = 4;
    //指示器宽度增量
    backgroundView.indicatorWidthIncrement = 6;
    backgroundView.verticalMargin = -38;
    //自动尺寸
    backgroundView.indicatorWidth = JXCategoryViewAutomaticDimension;
    backgroundView.indicatorColor = [UIColor colorWithHexString:@"#FB6463"];;
    self.myCategoryView.indicators = @[backgroundView];
    //将CategoryView加到navigationItem上
    self.navigationItem.titleView = self.myCategoryView;
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.myCategoryView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 40);
    
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
        BusinessNewsVC *businessVC = [[BusinessNewsVC alloc]init];
        //拿到要使用的模型数组
//        RankTeamListModel *tempModel = _teamListArray[0];
        //对改数组排序
//        NSArray *wzryArray = [self mySortArray:tempModel.list];
//        tempModel.list = wzryArray;
        //传递模型
//        wzryVC.WzryModel = tempModel;
        return businessVC;
    }
    else
    {
        TimeNewsVC *timeNewsVC = [[TimeNewsVC alloc]init];
        return timeNewsVC;
    }
}

@end
