//
//  PopularVC.m
//  forward
//
//  Created by apple on 2020/7/1.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "PopularVC.h"
#import "ShowNewsTableCell.h"

@interface PopularVC () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PopularVC

NSString *PopShowNewsID = @"ShowNewsTableCell";
- (void)viewDidLoad {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShowNewsTableCell class]) bundle:nil] forCellReuseIdentifier:PopShowNewsID];
}

- (UIView *)listView {
    return self.view;
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:PopShowNewsID forIndexPath:indexPath];
    return cell;
}

@end
