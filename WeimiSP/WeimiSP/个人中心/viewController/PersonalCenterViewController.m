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
#import "SettingViewController.h"
#import "PersonalInfoHeader.h"
#import "PersonalInfoViewController.h"
#import "MessageCenterViewController.h"
#import "BaiduLocationManage.h"


@interface PersonalCenterViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) PersonalInfoHeader *tableViewHeader;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIButton       *exitBtn;

@end

NSString * const personalCenterCell = @"PersonalCenterTableViewCell";

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


- (void)enterMessageCenter
{
    MessageCenterViewController *messageCenterVC = [[MessageCenterViewController alloc ]init];
    [self.navigationController pushViewController:messageCenterVC animated:YES];
}

#pragma mark - 实例化UI
- (void)initUI
{
    self.view.backgroundColor = VCBackgroundColor;
    self.title = @"个人中心";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont CustomFontOfSize:17]};
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"xiaoxi"] style:UIBarButtonItemStylePlain target:self action:@selector(enterMessageCenter)];
    messageItem.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = messageItem;
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - getter

- (PersonalInfoHeader *)tableViewHeader
{
    if (!_tableViewHeader) {
        _tableViewHeader = [[PersonalInfoHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        WEMEStoreCustomerServiceBO *userInfo = kAppDelegate.userInfo;
        [_tableViewHeader.userImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.headImgPath] placeholderImage:_tableViewHeader.userImageView.image];
        _tableViewHeader.userNameLabel.text = userInfo.name;
        _tableViewHeader.userTelLabel.text = userInfo.mobile;
        WEAK_SELF
        _tableViewHeader.editInfoActionBlock = ^(){
            NSLog(@"编辑信息");
            PersonalInfoViewController *infoVC = [[PersonalInfoViewController alloc] init];
            infoVC.headImage = weak_self.tableViewHeader.userImageView.image;
            infoVC.name = weak_self.tableViewHeader.userNameLabel.text;
            infoVC.tel = weak_self.tableViewHeader.userTelLabel.text;
            infoVC.updateHeadImageBlock = ^(UIImage *image){
                weak_self.tableViewHeader.userImageView.image = image;
            };
            infoVC.updateNameBlock = ^(NSString *name){
                weak_self.tableViewHeader.userNameLabel.text = name;
            };
            infoVC.updateTelBlock = ^(NSString *tel){
                weak_self.tableViewHeader.userTelLabel.text = tel;
            };
            [weak_self.navigationController pushViewController:infoVC animated:YES];
        };
    }
    return _tableViewHeader;
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
//        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"renwu"],@"title":@"任务订单"}];
//        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"qianbao"],@"title":@"钱包"}];
        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"setting"],@"title":@"设置"}];
    }
    return _dataSource;
}


#pragma mark - private methordr




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
//    WEAK_SELF
    switch (indexPath.section) {
//        case 0:
//        {
//            UpdatePasswordViewController *passwordVC = [[UpdatePasswordViewController alloc]init];
//            [self.mainNavController pushViewController:passwordVC animated:YES];
//        }
//            break;
//        case 1:
//        {
//            UpdateTelViewController *telVC = [[UpdateTelViewController alloc] init];
//            telVC.updateTelBlock = ^(NSString *tel){
//                weak_self.userTelLabel.text = tel;
//            };
//            [self.mainNavController pushViewController:telVC animated:YES];
//        }
//            break;
        case 0:
        {
            SettingViewController *settingVC = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:settingVC animated:YES];
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




@end
