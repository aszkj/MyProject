//
//  NewMessageVC.m
//  weimi
//
//  Created by thinker on 16/1/18.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "NewMessageVC.h"
#import "AppDelegate.h"
#import "JGTextView.h"
#import <IQKeyboardManager.h>
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import <WEMEFeedcontrollerApi.h>
#import "BaiduLocationManage.h"
#import "UploadFile.h"
#import <MBProgressHUD.h>
#import "UIImage+ImageEffects.h"

#define scrollViewHeight 236/3

@interface NewMessageVC ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (nonatomic, strong) JGTextView *contentText;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *addSubjectImage;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *friendBtn;
@property (nonatomic, strong) UIButton *nearbyBtn;

@property (nonatomic, strong) NSMutableArray *dataImage;


@end

@implementation NewMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.nearbyBtn.selected = YES;
    self.friendBtn.selected = YES;

}

#pragma mark - 实例化UI
- (void)initUI
{
    [self setNavigationItem];
    self.view.backgroundColor = [UIColor whiteColor];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    
    [self.view addSubview:self.contentText];
    [_contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@KLeftMargin);
        make.left.equalTo(@KLeftMargin);
        make.right.equalTo(@-KLeftMargin);
        make.height.equalTo(@120);
    }];
    [self.view addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@KLeftMargin);
        make.top.equalTo(_contentText.mas_bottom).with.offset(KLeftMargin);
        make.right.equalTo(@-KLeftMargin);
        make.height.equalTo(@(scrollViewHeight + 15));
    }];
    
    [self.view addSubview:self.lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_bottom).with.offset(KLeftMargin);
        make.left.equalTo(@KLeftMargin);
        make.right.equalTo(@-KLeftMargin);
        make.height.equalTo(@0.5);
    }];
    [self.view addSubview:self.friendBtn];
    [_friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(2 * KLeftMargin));
        make.width.equalTo(@120);
        make.height.equalTo(@29);
        make.top.equalTo(_lineView.mas_bottom).with.offset(KLeftMargin);
    }];
    [self.view addSubview:self.nearbyBtn];
    [_nearbyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_friendBtn);
        make.width.equalTo(_friendBtn);
        make.height.equalTo(_friendBtn);
        make.right.equalTo(@(-2 * KLeftMargin));
    }];
    
}
- (void)setNavigationItem {
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessageAction)];
    rightButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.title = @"发布新话题";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    kAppDelegate.tabBarHidden = YES;
//     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



#pragma mark - getter

-(UIButton *)addSubjectImage
{
    if (!_addSubjectImage) {
        _addSubjectImage = [UIButton buttonWithType:UIButtonTypeCustom];
        _addSubjectImage.tag = 1000;
        _addSubjectImage.frame = CGRectMake(0, 15, scrollViewHeight, scrollViewHeight);
        [_addSubjectImage setImage:[UIImage imageNamed:@"new_sendMessage"] forState:UIControlStateNormal];
        [_addSubjectImage addTarget:self action:@selector(addNewImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addSubjectImage;
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView addSubview:self.addSubjectImage];
    }
    return _scrollView;
}
-(NSMutableArray *)dataImage{
    if (!_dataImage) {
        _dataImage = [NSMutableArray array];
    }
    return _dataImage;
}

-(JGTextView *)contentText
{
    if (!_contentText) {
        _contentText = [[JGTextView alloc] initWithFrame:CGRectZero];
        _contentText.placeholder = @"这一刻的想法...";
        _contentText.placeholderColor = UIColorFromRGB(0Xb0b0b0);
        _contentText.font = KNormalFont;
    }
    return _contentText;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorFromRGB(0Xd3d5d8);
    }
    return _lineView;
}
-(UIButton *)friendBtn
{
    if (!_friendBtn) {
        _friendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_friendBtn setImage:[UIImage imageNamed:@"new_FriendSelect"] forState:UIControlStateNormal];
        [_friendBtn setImage:[UIImage imageNamed:@"new_Friend"] forState:UIControlStateSelected];
        [_friendBtn addTarget:self action:@selector(setSubjectTypeWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _friendBtn;
}
-(UIButton *)nearbyBtn
{
    if (!_nearbyBtn) {
        _nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nearbyBtn setImage:[UIImage imageNamed:@"new_nearbySelect"] forState:UIControlStateNormal];
        [_nearbyBtn setImage:[UIImage imageNamed:@"new_nearby"] forState:UIControlStateSelected];
        [_nearbyBtn addTarget:self action:@selector(setSubjectTypeWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nearbyBtn;
}

#pragma mark - private methord
-(void)sendMessageAction
{
    if (IsEmpty(self.contentText.text))
    {
        [Util ShowAlertWithOnlyMessage:@"发布新话题内容不能为空"];
        return;
    }
    if (self.friendBtn.selected == NO && self.nearbyBtn.selected == NO)
    {
        [Util ShowAlertWithOnlyMessage:@"请至少选择一个发布范围"];
        return;
    }
    
    [self.contentText resignFirstResponder];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在发布新话题...";
    [hud show:YES];
    
    BaiduLocationManage *location = [BaiduLocationManage shareManage];
    
    WEMEFeedRequest *request = [[WEMEFeedRequest alloc] init];
    WEMEPoint *point = [[WEMEPoint alloc] init];
    point.x = @(location.currentLocation.location.coordinate.longitude);
    point.y = @(location.currentLocation.location.coordinate.latitude);
    
    request.location = point;
    request.toFriendCircle = @(self.friendBtn.selected);
    request.toLbs = @(self.nearbyBtn.selected);
//    request.toService = @(1);
    
    WEMEContent *content = [[WEMEContent alloc] init];
//    content.text = self.contentText.text;
//    content.type = @"TEXT";

    request.content = content;
    
    WEAK_SELF
    if (self.dataImage.count > 0)
    {
        [[UploadFile shareInstance] uploadImageWithUIImage:self.dataImage[0] succeedBlock:^(NSString *url) {
            content.url = url;
//            content.type = @"IMAGE";
            [weak_self sendNewSubjectWith:request];
        }];
    }
    else
    {
        [self sendNewSubjectWith:request];
    }
    
    
}
#pragma mark - 新话题发布到服务器
-(void)sendNewSubjectWith:(WEMEFeedRequest *)request
{
    WEAK_SELF
    [[WEMEFeedcontrollerApi sharedAPI] publishUsingPOSTWithCompletionBlock:request completionHandler:^(WEMESingleObjectValueResponseOfFeed *output, NSError *error) {
        NSLog(@"ceshi ---- %@  ++  %@",output,error);
        if (output.success.integerValue == YES)
        {
            [kNotification postNotificationName:kNotificationSendNewMessage object:nil];
            [weak_self.navigationController popViewControllerAnimated:YES];

        }
        
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weak_self.view.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = output.success.integerValue ? @"发布成功":@"发布失败";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }];
}
//添加图片
- (void)addNewImage
{
    [self.view endEditing:YES];
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
    [action showInView:self.view];
}
-(void)setSubjectTypeWithButton:(UIButton *)btn
{
    btn.selected = !btn.selected;
}
//点击图片放大
-(void)tapImageViewEnlarge:(UIGestureRecognizer *)ges
{
    NSMutableArray *imageViewArr = [NSMutableArray array];
    for (UIView *v in self.scrollView.subviews)
    {
        if (v.tag < 1000 && v.tag >= 100)
        {
            UIImageView *img = (UIImageView *)v;
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.image = img.image;
            photo.srcImageView = img;
            [imageViewArr addObject:photo];
        }
    }
    // 2.显示相册  放大
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = ges.view.tag - 100; // 弹出相册时显示的第一张图片是？
    browser.photos = imageViewArr; // 设置所有的图片
    [browser show];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    switch (buttonIndex) {
        case 0://相机
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            picker.navigationBar.barTintColor = [UIColor blackColor];
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
        case 1://图片库
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.navigationBar.tintColor = [UIColor blackColor];
            [self presentViewController:picker  animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    UIImage *selectImage = [image imageByScalingToMaxSize:image];
    [self.dataImage removeAllObjects];
    [self.dataImage addObject:selectImage];
    for (UIView *v in self.scrollView.subviews)
    {
        [v removeFromSuperview];
    }
    WEAK_SELF
    [self.dataImage enumerateObjectsUsingBlock:^(UIImage *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:obj];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = idx + 100;
        imageView.frame = CGRectMake(idx * (scrollViewHeight + KLeftMargin), 15, scrollViewHeight, scrollViewHeight);
        [weak_self.scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewEnlarge:)];
        [imageView addGestureRecognizer:tap];
        
        //删除图片
        UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [delete setImage:[UIImage imageNamed:@"deleteImage"] forState:UIControlStateNormal];
        [delete addTarget:self action:@selector(deleteImageAction) forControlEvents:UIControlEventTouchUpInside];
        [weak_self.scrollView addSubview:delete];
        [delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.centerX.equalTo(imageView.mas_right).with.offset(0);
//            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
    }];
//    self.addSubjectImage.frame = CGRectMake(self.dataImage.count * (scrollViewHeight + KLeftMargin), 0, scrollViewHeight, scrollViewHeight);
//    [self.scrollView addSubview:self.addSubjectImage];
//    self.scrollView.contentSize = CGSizeMake((self.dataImage.count + 1) * (scrollViewHeight + KLeftMargin) - KLeftMargin, scrollViewHeight);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)deleteImageAction
{
    for (UIView *v in self.scrollView.subviews)
    {
        [v removeFromSuperview];
    }
    [self.scrollView addSubview:self.addSubjectImage];
}

@end
