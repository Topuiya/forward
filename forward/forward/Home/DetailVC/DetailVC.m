//
//  DetailVC.m
//  forward
//
//  Created by apple on 2020/7/8.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "DetailVC.h"
#import "DetailHeadTableCell.h"

@interface DetailVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailVC
NSString *DetailHeadCellID = @"DetailHeadTableCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情页";
    self.hbd_barTintColor = UIColor.whiteColor;
    //隐藏导航栏下面的阴影
    self.hbd_barShadowHidden = YES;
    self.hbd_tintColor = UIColor.blackColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailHeadTableCell class]) bundle:nil] forCellReuseIdentifier:DetailHeadCellID];
    
    NSLog(@"----昵称:%@",_newsModel.user.nickName);
}

- (void)viewDidAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailHeadTableCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailHeadCellID];
    cell.newsModel = _newsModel;
    return cell;
}


@end
