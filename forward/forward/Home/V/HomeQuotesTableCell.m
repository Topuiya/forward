//
//  HomeQuotesTableCell.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "HomeQuotesTableCell.h"
#import "QuotesCollectionCell.h"

@interface HomeQuotesTableCell () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation HomeQuotesTableCell

NSString *QuotesCollectionID = @"QuotesCollectionCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QuotesCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:QuotesCollectionID];
}

#pragma mark - <UICollectionViewDataSource>
//组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每组个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
//注册 Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QuotesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QuotesCollectionID forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//设置大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}
//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}
@end
