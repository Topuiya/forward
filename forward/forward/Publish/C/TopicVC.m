//
//  TopicVC.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "TopicVC.h"
#import "HotTopicTableCell.h"
#import "TopicHeadView.h"
#import "TopicFootView.h"
#import "TopicSortModel.h"
#import "PublishTopicVC.h"

@interface TopicVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *topicArray;
@end

@implementation TopicVC

NSString *HotTopicID = @"HotTopicTableCell";
- (NSArray *)topicArray {
    if (_topicArray == nil) {
        TopicSortModel *model1 = TopicSortModel.new;
        model1.head = @"topic_tu1";
        model1.title = @"#5月中国经济数据出炉#";
        model1.title2 = @"黄金板块集体高开，山东黄金高开7%，恒…";
        
        TopicSortModel *model2 = TopicSortModel.new;
        model2.head = @"tu2";
        model2.title = @"#黄金#";
        model2.title2 = @"黄金板块集体高开，山东黄金高开7%，恒…";
        
        TopicSortModel *model3 = TopicSortModel.new;
        model3.head = @"tu3";
        model3.title = @"#业绩预增#";
        model3.title2 = @"医改带来结构性机会，这些中报预增医药…";
        
        NSMutableArray *temp = NSMutableArray.new;
        [temp addObject:model1];
        [temp addObject:model2];
        [temp addObject:model3];
        
        _topicArray = temp;
    }
    return _topicArray;
}
- (void)viewDidLoad {
    //隐藏导航栏下面的阴影
    self.hbd_barShadowHidden = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotTopicTableCell class]) bundle:nil] forCellReuseIdentifier:HotTopicID];
}

- (UIView *)listView {
    return self.view;
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotTopicTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HotTopicID];
    cell.topicModel = self.topicArray[indexPath.row];
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    TopicHeadView *headView = TopicHeadView.new;
//    return headView;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    TopicFootView *footView = TopicFootView.new;
//    return footView;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PublishTopicVC *topicVC = PublishTopicVC.new;
    topicVC.topicModel = _topicArray[indexPath.row];
    [self.navigationController pushViewController:topicVC animated:YES];
}

@end
