//
//  PersonalInfoViewController.m
//  WeimiSP
//
//  Created by thinker on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonalCenterTableViewCell.h"
#import "UpdateNicknameViewController.h"
#import "UpdateTelViewController.h"
#import "ImageCropperPicker.h"
#import "UploadFile.h"
#import "WEMEUsercontrollerApi.h"
#import <WEMEStorecustomerservicecontrollerApi.h>
#import "AppDelegate.h"
#import "UpdatePasswordViewController.h"
#import "NewUpdateNickNameController.h"


@interface PersonalInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,VPImageCropperDelegate>

@property (nonatomic, strong) PersonalCenterTableViewCell *cellHeadImage;
@property (nonatomic, strong) PersonalCenterTableViewCell *cellName;
@property (nonatomic, strong) PersonalCenterTableViewCell *cellTel;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

NSString * const infoCell = @"PersonalInfoViewController";

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - 实例化UI
- (void)initUI
{
    self.view.backgroundColor = VCBackgroundColor;
    self.title = @"编辑资料";
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
    
}



#pragma mark - getter

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = KLeftMargin;
        _tableView.tableFooterView = [UIView new];
        [_tableView setSeparatorColor:UIColorFromRGB(0xe5e5e5)];
        [_tableView registerClass:[PersonalCenterTableViewCell class] forCellReuseIdentifier:infoCell];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        if (!IsEmpty(self.headImage)) {
            [_dataSource addObject:@{@"name":@"头像",@"text":self.headImage}];
        } else {
            [_dataSource addObject:@{@"name":@"头像",@"text":@""}];
        }
        
        if (!IsEmpty(self.name)) {
            [_dataSource addObject:@{@"name":@"昵称",@"text":self.name}];
        } else {
            [_dataSource addObject:@{@"name":@"昵称",@"text":@""}];
        }
        
        if (!IsEmpty(self.tel)) {
            [_dataSource addObject:@{@"name":@"手机号",@"text":self.tel}];
        } else {
            [_dataSource addObject:@{@"name":@"手机号",@"text":@""}];
        }
        [_dataSource addObject:@{@"name":@"修改密码",@"text":@""}];
    }
    return _dataSource;
}

-(PersonalCenterTableViewCell *)cellHeadImage
{
    if (!_cellHeadImage) {
        _cellHeadImage = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    return _cellHeadImage;
}
-(PersonalCenterTableViewCell *)cellName
{
    if (!_cellName) {
        _cellName = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    }
    return _cellName;
}

-(PersonalCenterTableViewCell *)cellTel
{
    if (_cellTel) {
        _cellTel = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    }
    return _cellTel;
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
    PersonalCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCell];
    if (_dataSource.count > indexPath.section)
    {
        NSDictionary *dataDict = self.dataSource[indexPath.section];
        cell.titleLabel.text = dataDict[@"name"];
        if (indexPath.section == 0)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.rightLabel.hidden = YES;
            cell.rightButton.hidden = NO;
            [cell.rightButton setBackgroundImage:(UIImage *)dataDict[@"text"] forState:UIControlStateNormal];
        }
        else
        {
            cell.rightButton.hidden = YES;
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = dataDict[@"text"];
        }
    }
    WEAK_SELF
    cell.updateHeadImageBlock = ^(){
        [weak_self updateUserHeadImageView];
    };
    return cell;
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 70;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            [self updateUserHeadImageView];
        }
            break;
        case 1:
        {
            NewUpdateNickNameController *nickNameVC = [[NewUpdateNickNameController alloc] init];
            nickNameVC.nickName = self.cellName.rightLabel.text;
            WEAK_SELF
            nickNameVC.updateNickeNameBlock = ^(NSString *name){
                PersonalCenterTableViewCell *cell = weak_self.cellName;
                cell.rightLabel.text = name;
                if (weak_self.updateNameBlock) {
                    weak_self.updateNameBlock(name);
                }
            };
            
            [self.navigationController pushViewController:nickNameVC animated:YES];
//            UpdateNicknameViewController *nicknameVC = [[UpdateNicknameViewController alloc] init];
//            nicknameVC.userNicknameTextField.text = self.cellName.rightLabel.text;
//            WEAK_SELF
//            nicknameVC.updateNickeNameBlock = ^(NSString *name){
//                PersonalCenterTableViewCell *cell = [weak_self.tableView cellForRowAtIndexPath:indexPath];
//                cell.rightLabel.text = name;
//                if (weak_self.updateNameBlock) {
//                    weak_self.updateNameBlock(name);
//                }
//            };
//            [self.navigationController pushViewController:nicknameVC animated:YES];
        }
            break;
//        case 2:
//        {
//            UpdateTelViewController *telVC = [[UpdateTelViewController alloc] init];
//            WEAK_SELF
//            telVC.updateTelBlock = ^(NSString *tel){
//                PersonalCenterTableViewCell *cell = [weak_self.tableView cellForRowAtIndexPath:indexPath];
//                cell.rightLabel.text = tel;
//                if (weak_self.updateTelBlock) {
//                    weak_self.updateTelBlock(tel);
//                }
//            };
//            [self.navigationController pushViewController:telVC animated:YES];
//        }
//            break;
        case 3:
        {
            UpdatePasswordViewController *updateVC = [[UpdatePasswordViewController alloc] init];
            [self.navigationController pushViewController:updateVC animated:YES];
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return KLeftMargin;
    }
    return 1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth, section == 0 ? KLeftMargin:1)];
    header.backgroundColor = [UIColor clearColor];
    return header;
}

#pragma mark - private methord
//修改用户头像
- (void)updateUserHeadImageView
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
    [action showInView:self.view];
}
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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
    __weak AppDelegate *weak_app = kAppDelegate;
    [[UploadFile shareInstance] uploadImageWithUIImage:image succeedBlock:^(NSString *url) {
        [[WEMEStorecustomerservicecontrollerApi sharedAPI ]updateAvatarUsingPOSTWithCompletionBlock:url completionHandler:^(WEMESimpleResponse *output, NSError *error) {
            if (IsEmpty(error) && output.success.integerValue == YES)
            {
                weak_app.userInfo.headImgPath = url;
                [weak_self.cellHeadImage.rightButton setBackgroundImage:image forState:UIControlStateNormal];
                if (weak_self.updateHeadImageBlock) {
                    weak_self.updateHeadImageBlock(image);
                }
            }
            else
            {
                if (IsEmpty(error))
                {
                    [Util ShowAlertWithOnlyMessage:output.errorDescription];
                }
                else
                {
                    [Util ShowAlertWithOnlyMessage:error.localizedDescription];
                }
            }
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        }];
    }];
    
}

@end
