//
//  AttentionTableCell.m
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "AttentionTableCell.h"
#import "AttentionCollectionCell.h"
#import "UserModel.h"

@interface AttentionTableCell () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *recommendArray;
@end

@implementation AttentionTableCell

NSString *AttentionCollectionID = @"AttentionCollectionCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AttentionCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:AttentionCollectionID];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    NSNumber *log = [EGHCodeTool getOBJCWithSavekey:isLog];
    if ([log isEqualToNumber:@1]) {
        [self getRecommendUsers];
    }
}
//获取推荐关注列表
-(void)getRecommendUsers{
    WEAKSELF
    //推荐用户清单接口
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    NSDictionary *dic = @{@"userId":user.userId};
    [ENDNetWorkManager getWithPathUrl:@"/user/follow/getRecommandUserList" parameters:nil queryParams:dic Header:nil success:^(BOOL success, id result) {
        NSError *error;
        //将拿到的结果传递给数组
        weakSelf.recommendArray = [MTLJSONAdapter modelsOfClass:[UserModel class] fromJSONArray:result[@"data"] error:&error];
        [weakSelf.collectionView reloadData];
    } failure:^(BOOL failuer, NSError *error) {
        NSLog(@"%@",error.description);
        [Toast makeText:self.contentView Message:@"请求推荐关注失败" afterHideTime:DELAYTiME];
    }];
}

#pragma mark - <UICollectionViewDataSource>

//每组个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recommendArray.count;
}
//注册 Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AttentionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AttentionCollectionID forIndexPath:indexPath];
    cell.recommandModel = self.recommendArray[indexPath.row];
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
