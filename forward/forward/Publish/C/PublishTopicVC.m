//
//  PublishTopicVC.m
//  forward
//
//  Created by apple on 2020/7/10.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "PublishTopicVC.h"

@interface PublishTopicVC () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation PublishTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布动态";
    self.hbd_tintColor = [UIColor colorWithHexString:@"333333"];
    self.contentTextView.delegate = self;
    self.contentTextView.text = _topicModel.title;
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

//关闭
- (IBAction)cancelBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//发布
- (IBAction)publishBtnClick:(id)sender {
}
//相册
- (IBAction)picBtnClick:(id)sender {
}
//相机
- (IBAction)cameraBtnClick:(id)sender {
}
//位置
- (IBAction)locationBtnClick:(id)sender {
}

@end
