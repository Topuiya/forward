//
//  MyInfoVC.m
//  forward
//
//  Created by apple on 2020/7/15.
//  Copyright © 2020 zzh. All rights reserved.
//

#import "MyInfoVC.h"
#import "UserModel.h"
#import <TZImagePickerController.h>
#import <SVProgressHUD.h>

@interface MyInfoVC () <TZImagePickerControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *signatureTextF;


//修改上传头像
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (copy, nonatomic) NSString *saveURL;
@property (nonatomic, strong) NSNumber *userId;
@end

@implementation MyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.hbd_tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:0 target:self action:@selector(savcBtnClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"#FB6473"];
    UserModel *user = [EGHCodeTool getOBJCWithSavekey:userModel];
    self.userId = user.userId;
    //添加头像点击事件
    self.headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateHeadImageView)];
    [self.headImageView addGestureRecognizer:headTap];
    self.nameTextF.delegate = self;
    self.signatureTextF.delegate = self;
}
- (void)savcBtnClick {
    [self saveChange];
}
- (void)saveChange {
    if (self.headImageView != nil && self.nameTextF.text.length > 0 && self.signatureTextF.text.length > 0) {
        [self uploadImg:self.headImageView.image];
        [self upUserNickName:self.nameTextF.text];
        [self upUserSignature:self.nameTextF.text];
    }
}

- (IBAction)changeHeadBtnClick:(id)sender {
    [self updateHeadImageView];
}
- (IBAction)changeheadClick:(id)sender {
    [self updateHeadImageView];
}
//修改头像
- (void)updateHeadImageView {
    [self pushTZImagePickerController];
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
        weakSelf.headImageView.image = selectedImg;
        [weakSelf uploadImg:weakSelf.headImageView.image];
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark -上传图片
//上传图片:resopnse是地址
-(void)uploadImg:(UIImage *)img{
    WEAKSELF
    NSDictionary *dict = @{
        @"file" : img
    };
    [NetworkTool.shared postReturnString:@"http://image.yysc.online/upload" fileName:@"testImg" image:img viewcontroller:self params:dict success:^(id _Nonnull resopnse) {
        weakSelf.saveURL = resopnse;
        //上传头像
        [weakSelf upHeadImg];
    } failture:^(NSError * _Nonnull error) {
        [Toast makeText:weakSelf.view Message:@"上传图片失败" afterHideTime:DELAYTiME];
    }];
}

#pragma mark -接口
//个性签名
-(void) upUserSignature :(NSString *)content{
    NSDictionary *dict = @{ @"id" : self.userId,
                            @"signature" : content
    };
    [ENDNetWorkManager putWithPathUrl:@"/user/personal/updateUser" parameters:dict queryParams:nil Header:nil success:^(BOOL success, id result) {
        
    } failure:^(BOOL failuer, NSError *error) {
        
    }];
}
//昵称
-(void) upUserNickName :(NSString *)content{
    [SVProgressHUD show];
    NSDictionary *dict = @{ @"id" : self.userId,
                            @"nickName" : content
    };
    [ENDNetWorkManager putWithPathUrl:@"/user/personal/updateUser" parameters:dict queryParams:nil Header:nil success:^(BOOL success, id result) {
        [SVProgressHUD dismiss];
    } failure:^(BOOL failuer, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
//头像
-(void) upHeadImg{
    NSDictionary *dict = @{ @"id" : self.userId,
                            @"head" : self.saveURL
    };
    [ENDNetWorkManager putWithPathUrl:@"/user/personal/updateUser" parameters:dict queryParams:nil Header:nil success:^(BOOL success, id result) {
        
    } failure:^(BOOL failuer, NSError *error) {
        
    }];
}

@end
