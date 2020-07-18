//
//  PublishTopicVC.m
//  forward
//
//  Created by apple on 2020/7/10.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "PublishTopicVC.h"
#import <TZImagePickerController.h>
#import "UITextView+WZB.h"
#import "UserModel.h"
#import <MBProgressHUD.h>
#import <SVProgressHUD.h>

@interface PublishTopicVC () <UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property (nonatomic, assign)BOOL selectedImg;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (copy, nonatomic)  NSString *saveURL;
@property (nonatomic, strong)NSNumber *userId;
@end

@implementation PublishTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布动态";
    self.hbd_tintColor = [UIColor colorWithHexString:@"333333"];
    self.contentTextView.delegate = self;
    self.contentTextView.text = _topicModel.title;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(cancelBtnClick)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"#666666"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:0 target:self action:@selector(publishBtnClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"#FB6473"];
    
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    self.userId = user.userId;
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
// MARK:按钮点击事件

- (void)cancelBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
//发布按钮点击
- (void)publishBtnClick {
    [self publishTalk];
}
//相册
- (IBAction)picBtnClick:(id)sender {
    //打开相册,选择图片
    [self pushTZImagePickerController];
}
//相机
- (IBAction)cameraBtnClick:(id)sender {
    //打开相机拍照
    [self takePhoto];
}
//位置
- (IBAction)locationBtnClick:(id)sender {
}

#pragma mark -辅助函数
-(void)makeAlert:(NSString *)info{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:info message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

// MARK: API
//发布说说
- (void)publish{
    WEAKSELF
    NSDictionary *dict;
    if(_selectedImg)
    {
        dict = @{
            @"userId" : _userId,
            @"content" : _contentTextView.text,
            @"picture" : self.saveURL
        };
    }
    else
    {
        dict = @{
            @"userId" : _userId,
            @"content" : _contentTextView.text,
        };
    }
    //发布动态接口
    [ENDNetWorkManager postWithPathUrl:@"/user/talk/publishTalk" parameters:nil queryParams:dict Header:nil success:^(BOOL success, id result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"发布说说成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertC addAction:action];
        
        [self presentViewController:alertC animated:YES completion:nil];
        
    } failure:^(BOOL failuer, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"MissingServletRequestParameterException:Required String parameter 'picture' is not present"]) {
            [weakSelf makeAlert:@"请选择图片"];
        }
        else{
            [weakSelf makeAlert:error.userInfo[@"NSLocalizedDescription"]];
        }
    }];
}

-(void)uploadImg:(UIImage *)img{
    WEAKSELF
    NSDictionary *dict = @{
        @"file" : img
    };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetworkTool.shared postReturnString:@"http://image.yysc.online/upload" fileName:@"testImg" image:img viewcontroller:self params:dict success:^(id _Nonnull resopnse) {
        weakSelf.saveURL = resopnse;
        weakSelf.selectedImg = YES;
        //发布说说
        [self publish];
    } failture:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Toast makeText:weakSelf.view Message:@"上传图片失败" afterHideTime:DELAYTiME];
    }];
}

- (void)publishTalk {
    if (self.selectedImg == YES) {
        [self uploadImg:_picImageView.image];
    }
    else{
        [self publish];
    }
}


#pragma mark - UIImagePickerController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

//相机获取照片
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photo = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.picImageView.image = photo;
    //已经选择过照片
    self.selectedImg = YES;
}

#pragma mark - TZImagePickerController
- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.naviBgColor = UIColorWithRGBA(255, 104, 74, 1);
    imagePickerVc.navigationBar.translucent = NO;
    
    imagePickerVc.isSelectOriginalPhoto = YES;
//    imagePickerVc.needShowStatusBar = NO;
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    
    //     imagePickerVc.photoWidth = 1600;
    //     imagePickerVc.photoPreviewMaxWidth = 1600;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = NO;
    
    //     imagePickerVc.minImagesCount = 3;
    //     imagePickerVc.alwaysEnableDoneBtn = YES;
    
    //裁剪
    imagePickerVc.allowCrop = YES;
    //圆形裁剪
//    imagePickerVc.needCircleCrop = YES;
    //    // 设置竖屏下的裁剪尺寸
    CGFloat width = 345;
    CGFloat height = 200;
    CGFloat x = (SCREEN_WIDTH - width) / 2;
    CGFloat y = (SCREEN_HEIGHT - height) / 2;
    imagePickerVc.cropRect = CGRectMake(x, y, width, height);
    imagePickerVc.scaleAspectFillCrop = YES;
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    WEAKSELF
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *selectedImg = photos[0];
        weakSelf.picImageView.image = selectedImg;
        //访问相册获取图片完毕,已经选择过照片
        self.selectedImg = YES;
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
