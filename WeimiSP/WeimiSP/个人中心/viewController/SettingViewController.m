//
//  SettingViewController.m
//  WeimiSP
//
//  Created by thinker on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "SettingViewController.h"
#import "PersonalCenterTableViewCell.h"
#import "DatabaseCache.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "XKJHNavRootController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>


@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

NSString  * const settingCell = @"SettingCell";

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 实例化UI
- (void)initUI
{
    self.view.backgroundColor = VCBackgroundColor;
    self.title = @"设置";
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = KLeftMargin;
        _tableView.tableFooterView = [UIView new];
        [_tableView setSeparatorColor:UIColorFromRGB(0xe5e5e5)];
        [_tableView registerClass:[PersonalCenterTableViewCell class] forCellReuseIdentifier:settingCell];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:@"当前版本"];
        [_dataSource addObject:@"退出登录"];
    }
    return _dataSource;
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
    PersonalCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
    if (_dataSource.count > indexPath.section)
    {
        cell.titleLabel.text = self.dataSource[indexPath.section];
        cell.rightLabel.textColor = UIColorFromRGB(0X999999);
        if (indexPath.section == 0)
        {
            cell.rightLabel.hidden = NO;
        }
        else
        {
            cell.rightLabel.hidden = YES;
            [cell.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(@0);
            }];
        }
    }
    cell.rightImageView.hidden = YES;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要退出该账户？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alertView show];
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

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [kUserDefaults removeObjectForKey:Token];
        [kUserDefaults synchronize];
        
        [kAppDelegate initApiClient];
        [kAppDelegate disConnect];
        [[DatabaseCache shareInstance] DeleteAllByTableName:KTableNameOfSessionContent];
        LoginController *loginVC = [[LoginController alloc] init];
        
        XKJHNavRootController *nav = [[XKJHNavRootController alloc] initWithRootViewController:loginVC];
        kAppDelegate.window.rootViewController = nav;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        });
    }
}

@end
