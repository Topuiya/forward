//
//  PublishVC.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "PublishVC.h"
#import "JXCategoryTitleView.h"
#import "AttentionVC.h"
#import "PopularVC.h"
#import "TopicVC.h"

@interface PublishVC () <JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;

@end

@implementation PublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hbd_barTintColor = UIColor.clearColor;
    //隐藏导航栏下面的阴影
    self.hbd_barShadowHidden = YES;
    self.titles = @[@"关注", @"推荐", @"话题", ];
    
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)self.categoryView;
    titleCategoryView.titles = self.titles;
    titleCategoryView.titleColor = [UIColor colorWithHexString:@"#666666"];
    titleCategoryView.titleSelectedColor = [UIColor colorWithHexString:@"#FB6463"];
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.titleLabelZoomEnabled = YES;
    titleCategoryView.titleLabelZoomScale = 1.3;
    titleCategoryView.titleLabelStrokeWidthEnabled = YES;
    titleCategoryView.selectedAnimationEnabled = YES;
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
    return  3;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0)
    {
        AttentionVC *attentiopnVC = [[AttentionVC alloc]init];
        //拿到要使用的模型数组
//        RankTeamListModel *tempModel = _teamListArray[0];
        //对改数组排序
//        NSArray *wzryArray = [self mySortArray:tempModel.list];
//        tempModel.list = wzryArray;
        //传递模型
//        wzryVC.WzryModel = tempModel;
        return attentiopnVC;
    }
    else if(index == 1)
    {
        PopularVC *lolVC = [[PopularVC alloc]init];
        return lolVC;
    }
    else
    {
        TopicVC *topicVC = [[TopicVC alloc]init];
        topicVC.hbd_barShadowHidden = YES;
        return topicVC;
    }
    
}

@end
