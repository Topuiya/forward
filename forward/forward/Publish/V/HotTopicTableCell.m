//
//  HotTopicTableCell.m
//  forward
//
//  Created by apple on 2020/7/2.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "HotTopicTableCell.h"

@interface HotTopicTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ohterLabel;

@end
@implementation HotTopicTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setTopicModel:(TopicSortModel *)topicModel {
    _topicModel = topicModel;
    self.headImageview.image = [UIImage imageNamed:topicModel.head];
    self.titleLabel.text = topicModel.title;
    self.ohterLabel.text = topicModel.title2;
}

@end
