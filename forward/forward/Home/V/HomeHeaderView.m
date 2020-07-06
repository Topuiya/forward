//
//  HomeHeaderView.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "HomeHeaderView.h"
#import "HomeBannerDataModel.h"

#import <FSPagerView/FSPagerViewObjcCompat.h>
#import <FSPagerView/FSPagerView-Swift.h>

@interface HomeHeaderView () <FSPagerViewDelegate,FSPagerViewDataSource>
//顶部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewTop;

@property (nonatomic, strong) NSArray *bannerArray;
@property (weak, nonatomic) IBOutlet FSPagerView *pagerView;
@property (weak, nonatomic) IBOutlet FSPageControl *pageControl;
/*四个分类View*/
@property (weak, nonatomic) IBOutlet UIView *calendarView;

@end

@implementation HomeHeaderView

- (NSArray *)bannerArray {
    if (_bannerArray == nil) {
        HomeBannerDataModel *bannerModelA = HomeBannerDataModel.new;
        bannerModelA.avatarImgName = @"banner1";
        
        HomeBannerDataModel *bannerModelB = HomeBannerDataModel.new;
        bannerModelB.avatarImgName = @"banner2";
        
        HomeBannerDataModel *bannerModelC = HomeBannerDataModel.new;
        bannerModelC.avatarImgName = @"banner3";
        
        HomeBannerDataModel *bannerModelD = HomeBannerDataModel.new;
        bannerModelD.avatarImgName = @"banner4";
        
        NSMutableArray *temp = NSMutableArray.new;
        [temp addObject:bannerModelA];
        [temp addObject:bannerModelB];
        [temp addObject:bannerModelC];
        [temp addObject:bannerModelD];
        _bannerArray = temp;
    }
    return _bannerArray;
}

NSString *HomeBannerCellID = @"BannerCell";

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[NSBundle mainBundle]loadNibNamed:@"HomeHeaderView" owner:self options:nil].firstObject;
    if (self) {
        self.frame = frame;
    }
    if (kIsIPhoneX_Series) {
        self.searchViewTop.constant += 20;
    }
    [self addFSPagerView];
    
    [self addViewTapGesture];
    
    return self;
}

//添加View手势
- (void)addViewTapGesture {
    //日历数据
    self.calendarView.userInteractionEnabled = YES;
    UITapGestureRecognizer *calendarViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectedCarlendarView)];
    [self.calendarView addGestureRecognizer:calendarViewTap];
}

- (void)didSelectedCarlendarView {
    if ([self.delegate respondsToSelector:@selector(didSelectedCarlendarView)]) {
        [self.delegate didSelectedCarlendarView];
    }
}

- (void)addFSPagerView {
    self.pagerView.delegate = self;
    self.pagerView.dataSource = self;

    self.pagerView.layer.shadowRadius = 0;
    self.pagerView.layer.shadowOpacity = 0;
    
    //效果:交叠
    self.pagerView.transformer = [[FSPagerViewTransformer alloc] initWithType:FSPagerViewTransformerTypeOverlap];
    self.pagerView.itemSize = FSPagerViewAutomaticSize;
    
    self.pageControl.numberOfPages = self.bannerArray.count;
    self.pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.pageControl setImage:[UIImage imageNamed:@"bannergundong"] forState:UIControlStateNormal];
    [self.pageControl setImage:[UIImage imageNamed:@"bannerxinshigundong"] forState:UIControlStateSelected];
    [self.pagerView registerClass:[FSPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
}
#pragma mark - FSPagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(FSPagerView *)pagerView
{
    return self.bannerArray.count;
}

- (FSPagerViewCell *)pagerView:(FSPagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    FSPagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell" atIndex:index];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    HomeBannerDataModel *pageModel = HomeBannerDataModel.new;
    pageModel = self.bannerArray[index];
    cell.imageView.image = [UIImage imageNamed:pageModel.avatarImgName];
    return cell;
}

#pragma mark - FSPagerViewDelegate
- (void)pagerView:(FSPagerView *)pagerView didSelectItemAtIndex:(NSInteger)index
{
    [pagerView deselectItemAtIndex:index animated:YES];
    [pagerView scrollToItemAtIndex:index animated:YES];
}
- (void)pagerViewWillEndDragging:(FSPagerView *)pagerView targetIndex:(NSInteger)targetIndex
{
    self.pageControl.currentPage = targetIndex;
}

- (void)pagerViewDidEndScrollAnimation:(FSPagerView *)pagerView
{
    self.pageControl.currentPage = pagerView.currentIndex;
}

@end
