//
//  EditPersonInfoController.m
//  weimi
//
//  Created by 张康健 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "EditPersonInfoController.h"
#import "HeadImgCell.h"
#import "CommentInfoCell.h"
#import "NewUpdateNickNameController.h"
#import "UpdateTelViewController.h"
#import "ImageCropperPicker.h"
#import "UploadFile.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "WEMEUsercontrollerApi.h"
#import "WEMEModelExtension.h"
#import "UpdatePasswordViewController.h"

static NSString *headImgCellID = @"headImgCellID";
static NSString *normalInfoCellID = @"normalInfoCellID";

@interface EditPersonInfoController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate,VPImageCropperDelegate>

@property (nonatomic,strong)UITableView *editPersonInfoTableView;

@end

@implementation EditPersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initTable];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark ----------------------- Action Method -----------------------
- (void)_initTable {
    
    _editPersonInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarAndStatusBarHeight-10)];
    [self.view addSubview:_editPersonInfoTableView];
    _editPersonInfoTableView.backgroundColor = kGetColor(241, 243, 248);
    _editPersonInfoTableView.delegate = self;
    _editPersonInfoTableView.dataSource = self;
    _editPersonInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_editPersonInfoTableView registerClass:[HeadImgCell class] forCellReuseIdentifier:headImgCellID];
     [_editPersonInfoTableView registerClass:[CommentInfoCell class] forCellReuseIdentifier:normalInfoCellID];
    //navigation_back
}


- (void)_init {
    self.view.backgroundColor = kGetColor(241, 243, 248);
    self.title = @"编辑资料";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"navigation_back" target:self action:@selector(back)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        HeadImgCell *headerImgCell = [tableView dequeueReusableCellWithIdentifier:headImgCellID forIndexPath:indexPath];
        WEAK_SELF
        headerImgCell.updateHeaderImgBlock = ^{
            [weak_self updateUserHeadImageView];
        };
        headerImgCell.headerImgView.image = self.headerImage;
        return headerImgCell;
        
    } else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
        
        CommentInfoCell *commentInfoCell = [tableView dequeueReusableCellWithIdentifier:normalInfoCellID forIndexPath:indexPath];
        NSString *leftTitle;
        NSString *rightTitle;
        if (indexPath.row == 1) {
            commentInfoCell.leftLabel.text = @"昵称";
            leftTitle = @"昵称";
            rightTitle = self.nickName;
        } else if (indexPath.row == 2) {
            leftTitle = @"手机号";
            rightTitle = self.telNumber;
        } else if (indexPath.row == 3) {
            leftTitle = @"修改密码";
        }
        commentInfoCell.leftLabel.text = leftTitle;
        [commentInfoCell.rightButton setTitle:rightTitle forState:UIControlStateNormal];
        return commentInfoCell;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 84;
        
    }
        
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {//修改头像
        [self updateUserHeadImageView];
    }else if (indexPath.row == 1){//修改昵称
        
        NewUpdateNickNameController *updateNickNameController = [[NewUpdateNickNameController alloc] init];
        
        WEAK_SELF;
        updateNickNameController.updateNickeNameBlock = ^(NSString *name){
            
            CommentInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            weak_self.nickName = name;
            [cell.rightButton setTitle:name forState:UIControlStateNormal];
        };
        
        updateNickNameController.nickName = self.nickName;
        [self.navigationController pushViewController:updateNickNameController animated:YES];

    } else if (indexPath.row == 2){//修改手机号码
        UpdateTelViewController *updateTelVC = [[UpdateTelViewController alloc] init];
        WEAK_SELF;
        updateTelVC.updateTelBlock = ^(NSString *telNumber){
            CommentInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.rightButton setTitle:telNumber forState:UIControlStateNormal];
            weak_self.telNumber = telNumber;
        };
        [self.navigationController pushViewController:updateTelVC animated:YES];
    } else if (indexPath.row == 3) {
        UpdatePasswordViewController *updatePasswordVC = [[UpdatePasswordViewController alloc] init];
        [self.navigationController pushViewController:updatePasswordVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 修改头像
- (void)updateUserHeadImageView
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
    [action showInView:self.view];
}
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ImageCropperPicker *picker = [[ImageCropperPicker alloc] init];
    picker.navigationBar.barTintColor = chatStatus_Color;
    
    switch (buttonIndex) {
        case 0://相机
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.dataSource = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
        case 1://图片库
        {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.dataSource = self;
            [self presentViewController:picker  animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    [self updateUserImageWithImage:editedImage];
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    //    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    //
    //    }];
}
#pragma mark - 修改头像
- (void)updateUserImageWithImage:(UIImage *)image
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在修改用户头像...";
    [hud show:YES];
    WEAK_SELF
    [[UploadFile shareInstance] uploadImageWithUIImage:image succeedBlock:^(NSString *url) {
        if (url == nil) {
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
            return;
        }
        
        [[WEMEUsercontrollerApi sharedAPI] updateAvatarUsingPOST1WithCompletionBlock:url completionHandler:^(WEMESimpleResponse *output, NSError *error) {
            if (IsEmpty(error) && output.success.integerValue == YES)
            {
                HeadImgCell *cell = [self.editPersonInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                cell.headerImgView.image = image;
                self.headerImage = image;
                [WEMESimpleUser updateSelfSimpleUser];
            }
            else
            {
                [NSError checkErrorFromServer:error response:output];
            }
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        }];
    }];
    
}

- (void)back {
    if (self.editPersonInfoBlock) {
        self.editPersonInfoBlock(self.nickName,self.headerImage,self.telNumber);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
