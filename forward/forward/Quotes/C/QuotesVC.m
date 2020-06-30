//
//  QuotesVC.m
//  forward
//
//  Created by apple on 2020/6/30.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "QuotesVC.h"
#import "QuotesCenterTableCell.h"
#import "QuotesHeadView.h"

@interface QuotesVC () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QuotesVC

NSString *QuotesCenterTableCellID = @"QuotesCenterTableCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QuotesCenterTableCell class]) bundle:nil] forCellReuseIdentifier:QuotesCenterTableCellID];
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = @"行情中心";
    self.hbd_barTintColor = UIColor.whiteColor;
}

#pragma mark - UITableViewViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuotesCenterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:QuotesCenterTableCellID];
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QuotesHeadView *headView = [[QuotesHeadView alloc] init];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

@end
