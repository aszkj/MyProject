//
//  PersonalCenterViewController.m
//  weimi
//
//  Created by thinker on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "AppDelegate.h"
#import "PersonalCenterTableViewCell.h"
#import "UpdateNicknameViewController.h"
#import "UpdateTelViewController.h"
#import "UpdatePasswordViewController.h"
#import "LoginController.h"
#import <WEMEUsercontrollerApi.h>
#import <ReactiveCocoa.h>
#import "AppDelegate.h"
#import "UploadFile.h"
#import <UIImageView+WebCache.h>
#import "ImageCropperPicker.h"
#import "DatabaseCache.h"
#import "UIImage+ImageEffects.h"
#import "EditPersonInfoController.h"
#import "SetViewController.h"

@interface PersonalCenterViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate,VPImageCropperDelegate>

@property (nonatomic, strong) UIView         *tableViewHeader;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *userAgeImageView;
@property (nonatomic, strong) UIImageView *userConstellation;
@property (nonatomic, strong) UILabel *userTelLabel;
@property (nonatomic, strong) UILabel *userLocationLabel;
@property (nonatomic, strong) UIButton *userEditDataBtn;


@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIButton       *exitBtn;

@end

NSString * const personalCenterCell = @"PersonalCenterTableViewCell";

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requetData];
}

#pragma mark - 请求数据
-(void)requetData
{
    WEAK_SELF
    [[WEMEUsercontrollerApi sharedAPI] getMyProfileUsingGETWithCompletionBlock:^(WEMESingleObjectValueResponseOfSimpleUser *output, NSError *error) {
        if ([output.success boolValue])
        {
            [weak_self.userImageView sd_setImageWithURL:[NSURL URLWithString:output.item.avatar] placeholderImage:weak_self.userImageView.image];
            weak_self.userNameLabel.text = output.item.nickname;
            weak_self.userTelLabel.text = output.item.username;
        }
        
        [NSError checkErrorFromServer:error response:output];
        
    }];
}

#pragma mark - 实例化UI
- (void)initUI
{
    self.view.backgroundColor = UIColorFromRGB(0xf1f3f8);
    self.title = @"个人中心";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.exitBtn];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(_exitBtn.mas_top).with.offset(-KLeftMargin);
        make.top.equalTo(@0);
    }];
    [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(140/3));
        make.bottom.equalTo(@(- 2 * KLeftMargin));
        make.left.equalTo(@KLeftMargin);
        make.right.equalTo(@-KLeftMargin);
    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - getter

-(UIView *)tableViewHeader
{
    if (!_tableViewHeader) {
        _tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
        _tableViewHeader.backgroundColor = [UIColor clearColor];
        UIView *headerContent = [[UIView alloc] init];
        headerContent.backgroundColor = kWhiteColor;
        [_tableViewHeader addSubview:headerContent];
        [headerContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@KLeftMargin);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
        [headerContent addSubview:self.userImageView];
        [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@KLeftMargin);
            make.centerY.equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        [headerContent addSubview:self.userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(2*KLeftMargin));
            make.left.equalTo(_userImageView.mas_right).with.offset(KLeftMargin);
            make.width.lessThanOrEqualTo(@(kScreenWidth - 175));
            make.height.equalTo(@20);
        }];
        [headerContent addSubview:self.userAgeImageView];
        [_userAgeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_userNameLabel);
            make.left.equalTo(_userNameLabel.mas_right).with.offset(5);
        }];
        [headerContent addSubview:self.userConstellation];
        [_userConstellation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userAgeImageView.mas_right).with.offset(5);
            make.centerY.equalTo(_userAgeImageView);
        }];
        [headerContent addSubview:self.userTelLabel];
        [_userTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userNameLabel.mas_bottom).with.offset(20 / 3);
            make.left.equalTo(_userImageView.mas_right).with.offset(KLeftMargin);
            make.height.equalTo(@15);
        }];
        UIImageView *locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalCenter_GPS"]];
        [headerContent addSubview:locationImageView];
        [headerContent addSubview:self.userLocationLabel];
        [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userImageView.mas_right).with.offset(KLeftMargin);
            make.top.equalTo(_userTelLabel.mas_bottom).with.offset(20 / 3);
        }];
        [_userLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(locationImageView);
            make.left.equalTo(locationImageView.mas_right).with.offset(20/3);
        }];
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personalCenter_right"]];
        [headerContent addSubview:rightImageView];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.right.equalTo(@(-KLeftMargin));
        }];
        
        //编辑资料
        [headerContent addSubview:self.userEditDataBtn];
        [_userEditDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.right.equalTo(rightImageView.mas_left).with.offset(-KLeftMargin);
        }];
        
        
        
    }
    return _tableViewHeader;
}

-(UIImageView *)userImageView
{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_head"]];
        _userImageView.layer.cornerRadius = 30;
        _userImageView.clipsToBounds = YES;
        _userImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateUserHeadImageView)];
        [_userImageView addGestureRecognizer:tap];
    }
    return _userImageView;
}
-(UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc ]init];
        _userNameLabel.font = KBigFont;
        _userNameLabel.textColor = UIColorFromRGB(0X333333);
        _userNameLabel.text = @"";
    }
    return _userNameLabel;
}
-(UIImageView *)userAgeImageView{
    if (!_userAgeImageView) {
        _userAgeImageView = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"personalCenter_age"]];
        _userAgeImageView.hidden = YES;
    }
    return _userAgeImageView;
}
-(UIImageView *)userConstellation{
    if (!_userConstellation) {
        _userConstellation = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"personalCenter_constellation"]];
        _userConstellation.hidden = YES;
    }
    return _userConstellation;
}
-(UILabel *)userTelLabel
{
    if (!_userTelLabel) {
        _userTelLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _userTelLabel.font = [UIFont customFontOfSize:13];
        _userTelLabel.text = @" ";
        _userTelLabel.textColor = UIColorFromRGB(0x000000);
    }
    return _userTelLabel;
}
-(UILabel *)userLocationLabel
{
    if (!_userLocationLabel) {
        _userLocationLabel = [[UILabel alloc] init];
        _userLocationLabel.textColor = UIColorFromRGB(0Xababab);
        _userLocationLabel.font = [UIFont customFontOfSize:10];
        _userLocationLabel.text = @"深圳";
    }
    return _userLocationLabel;
}
-(UIButton *)userEditDataBtn
{
    if (!_userEditDataBtn) {
        _userEditDataBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_userEditDataBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
        [_userEditDataBtn setTitleColor:UIColorFromRGB(0Xababab) forState:UIControlStateNormal];
        _userEditDataBtn.titleLabel.font = [UIFont customFontOfSize:40/3];
        [_userEditDataBtn addTarget:self action:@selector(updateUserInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userEditDataBtn;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = KLeftMargin;
        _tableView.tableHeaderView = self.tableViewHeader;
        _tableView.tableFooterView = [UIView new];
        [_tableView setSeparatorColor:UIColorFromRGB(0xe5e5e5)];
        [_tableView registerClass:[PersonalCenterTableViewCell class] forCellReuseIdentifier:personalCenterCell];
    }
    return _tableView;
}
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
//        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"personalCenter_password"],@"title":@"订单管理"}];
//        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"personalCenter_UpdateTel"],@"title":@"收货地址"}];
        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"personalCenter_UpdateTel"],@"title":@"设置"}];
    }
    return _dataSource;
}


-(UIButton *)exitBtn{
    if (!_exitBtn) {
        _exitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_exitBtn setTitle:@"退出" forState:UIControlStateNormal];
        [_exitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_exitBtn setBackgroundImage:[UIImage imageNamed:@"personalCenter_exitBack"] forState:UIControlStateNormal];
        _exitBtn.hidden = YES;
        [_exitBtn addTarget:self action:@selector(userExit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}

#pragma mark - private methordr

//修改用户头像
- (void)updateUserHeadImageView
{
//    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
//    [action showInView:self.view];
}
//修改用户资料
- (void)updateUserInfo
{
//    WEAK_SELF
//    UpdateNicknameViewController *updateNicknameVC = [[UpdateNicknameViewController alloc] init];
//    updateNicknameVC.userNicknameTextField.text = self.userNameLabel.text;
//    updateNicknameVC.updateNickeNameBlock = ^(NSString *name){
//        weak_self.userNameLabel.text = name;
//    };
//    [self.navigationController pushViewController:updateNicknameVC animated:YES];
    EditPersonInfoController *editPersonInfoVC = [[EditPersonInfoController alloc] init];
    editPersonInfoVC.headerImage = self.userImageView.image;
    editPersonInfoVC.nickName = self.userNameLabel.text;
    editPersonInfoVC.telNumber = self.userTelLabel.text;
    WEAK_SELF;
    editPersonInfoVC.editPersonInfoBlock = ^(NSString *nickName,UIImage *headerImage,NSString *telNumber){
        weak_self.userImageView.image = headerImage;
        weak_self.userNameLabel.text = nickName;
        weak_self.userTelLabel.text = telNumber;
    };
    [self.navigationController pushViewController:editPersonInfoVC animated:YES];
    
}
- (void)userExit
{
    NSLog(@"退出用户");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要退出该账户？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:personalCenterCell];
    if (_dataSource.count > indexPath.section)
    {
        NSDictionary *dataDict = self.dataSource[indexPath.section];
        cell.titleImageView.image = dataDict[@"image"];
        cell.titleLabel.text = dataDict[@"title"];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF
    switch (indexPath.section) {
        case 0:
        {
            //订单管理
            //设置
            SetViewController *setVC = [[SetViewController alloc] init];
            setVC.telNumber = weak_self.userTelLabel.text;
            [self.navigationController pushViewController:setVC animated:YES];
        }
            break;
        case 1:
        {
            //收货地址
            
        }
            break;
        case 2:
        {
            //设置
            SetViewController *setVC = [[SetViewController alloc] init];
            setVC.telNumber = weak_self.userTelLabel.text;
            [self.navigationController pushViewController:setVC animated:YES];
        }
            break;

        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth, KLeftMargin)];
    header.backgroundColor = [UIColor clearColor];
    return header;
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    switch (buttonIndex) {
        case 0://相机
        {
            ImageCropperPicker *picker = [[ImageCropperPicker alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.dataSource = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
        case 1://图片库
        {
            ImageCropperPicker *picker = [[ImageCropperPicker alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.dataSource = self;
            [self presentViewController:picker  animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }

}

//#pragma mark - UIImagePickerControllerDelegate
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
//{
//    [picker dismissViewControllerAnimated:YES completion:^{
//        // 裁剪
//        UIImage *selectImage = [image imageByScalingToMaxSize:image];
//        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:selectImage cropFrame:CGRectMake(0, self.view.frame.size.height / 4, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
//        imgEditorVC.delegate = self;
//        [self presentViewController:imgEditorVC animated:YES completion:nil];
//    }];
//    
//}

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
        [[WEMEUsercontrollerApi sharedAPI] updateAvatarUsingPOST1WithCompletionBlock:url completionHandler:^(WEMESimpleResponse *output, NSError *error) {
            if (IsEmpty(error) && output.success.integerValue == YES)
            {
                weak_self.userImageView.image = image;
            }
            else
            {
                [NSError checkErrorFromServer:error response:output];
            }
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        }];
    }];

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [kAppDelegate userExit];
    }
}

@end
