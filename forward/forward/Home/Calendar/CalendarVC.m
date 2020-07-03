//
//  CalendarVC.m
//  forward
//
//  Created by apple on 2020/7/3.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "CalendarVC.h"
#import "CalendarHeadView.h"
#import "CalendarTableViewCell.h"
#import "UIImage+OriginalImage.h"

@interface CalendarVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CalendarVC

NSString *CalendarTableID = @"CalendarTableViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hbd_barTintColor = UIColor.whiteColor;
    //隐藏导航栏下面的阴影
    self.hbd_barShadowHidden = YES;
    self.hbd_tintColor = UIColor.blackColor;
    self.title = @"日历数据";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage originalImageWithName:@"icon_rili"] style:UIBarButtonItemStyleDone target:self action:@selector(calendarBtnClick)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CalendarTableViewCell class]) bundle:nil] forCellReuseIdentifier:CalendarTableID];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)calendarBtnClick {
    
}

#pragma mark - UITableViewViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CalendarTableID];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CalendarHeadView *headView = CalendarHeadView.new;
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

@end
