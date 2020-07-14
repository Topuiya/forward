//
//  AttentionTableCell.m
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "AttentionTableCell.h"
#import "AttentionCollectionCell.h"

@interface AttentionTableCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation AttentionTableCell

NSString *AttentionCollectionID = @"AttentionCollectionCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AttentionCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:AttentionCollectionID];
}

#pragma mark - <UICollectionViewDataSource>
//组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每组个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _modelArray.count;
}
//注册 Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AttentionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AttentionCollectionID forIndexPath:indexPath];
    cell.recommandModel = _modelArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//设置大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(120, 160);
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
