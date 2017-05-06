//
//  MainViewController.m
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "MainViewController.h"
#import "CustomBasicTableViewCell.h"
#import "WalletViewController.h"
#import "MerchantManagerViewController.h"
#import "MembersManagerViewController.h"
#import "BaseInfoViewController.h"
#import "XKO_SetttingViewController.h"
#import "XKO_UserTestController.h"
#import "XKO_BaseInfoResponseInfo.h"
#import "BaseInfoViewModel.h"
#import "StatisticsAllController.h"

#import "ComplainManagerController.h"
//#import "SummaryController.h"
#import "NoticeController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) BaseInfoViewModel *viewModel;
@property (nonatomic,strong ) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

static NSString *cellIdentifier = @"CustomBasicTableViewCell";

@implementation MainViewController



- (void)pushUserTestVC {
    
    XKO_UserTestController *userTestVC = [[XKO_UserTestController alloc] init];
    [self.navigationController pushViewController:userTestVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
//    UIButton *userTestBtn = [self createUIButtonWithFrame:CGRectMake(10, self.view.frame.size.height - 120, 80, 40) title:@"测试用例" titleColor:KColorText333333 titleFont:kFontSize16 backgroundColor:KColorText999999 hasRadius:YES targetSelector:@selector(pushUserTestVC) target:self];
//    
//    [self.view addSubview:userTestBtn];
}

- (void)requestData
{
    XKO_BaseInfoRequestInfo *info = [[XKO_BaseInfoRequestInfo alloc] init];
    [self.dataCenter requestOperatorInfoFromModel:info successBlk:^(NSArray *responseData) {
        XKO_BaseInfoResponseInfo *responeseInfo = responseData[0];
        [Util setNavTitleWithTitle:responeseInfo.operatorName ofVC:self];
    } failBlk:^(NSError *error) {
        self.viewModel.error = error;
    }];
    //我的钱包，汇总统计，商户管理，会员管理，投诉管理，平台公告，基本信息
    [self.dataSource addObject:@{@"title":@"我的钱包",
                                 @"left":@"iconfont-wodeqianbao---Assistor"}];
    [self.dataSource addObject:@{@"title":@"汇总统计",
                                 @"left":@"icon_statistics"}];
    [self.dataSource addObject:@{@"title":@"商户管理",
                                 @"left":@"iconfont-lladdresshome---Assistor"}];
    [self.dataSource addObject:@{@"title":@"会员管理",
                                 @"left":@"iconfont-huiyuan---Assistor"}];
    [self.dataSource addObject:@{@"title":@"投诉管理",
                                 @"left":@"iconfont-wenjian---Assistor"}];
    [self.dataSource addObject:@{@"title":@"公告",
                                 @"left":@"icon_home_notice"}];
    [self.dataSource addObject:@{@"title":@"基本信息",
                                 @"left":@"iconfont-wenjian---Assistor"}];
    [self.tableView reloadData];
}
#pragma mark - 系统设置事件激活
- (void)settingAction
{
    XKO_SetttingViewController *settingVC = [[XKO_SetttingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - 设置UI外观


- (void)setUIAppearance {
    [super setUIAppearance];
    _dataSource = [NSMutableArray array];
    [Util setNavTitleWithTitle:@"云e生运营商" ofVC:self];
    
    UIButton *setRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setRightBtn.frame = CGRectMake(0, 0, 32, 32);
    [setRightBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [setRightBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setRightBtn];
}
- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 99.0 / 2;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        [ _tableView registerNib:[UINib nibWithNibName:@"CustomBasicTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (BaseInfoViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[BaseInfoViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.basicTitle.text = dict[@"title"];
    cell.leftImageView.image = [UIImage imageNamed:dict[@"left"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //我的钱包，汇总统计，商户管理，会员管理，投诉管理，平台公告，基本信息
    switch (indexPath.row)
    {
        case 0:
        {
            // 我的钱包
            WalletViewController *walleteVC =[[WalletViewController alloc] initWithNibName:@"WalletViewController" bundle:nil];
            [self.navigationController pushViewController:walleteVC animated:YES];
        }
            break;
        case 1:
        {
            
            // 汇总统计
            StatisticsAllController *statisticsAllController = [[StatisticsAllController alloc]init];
            [self.navigationController pushViewController:statisticsAllController animated:YES];
        }
            break;
        case 2:
        {
            // 商户管理
            MerchantManagerViewController *merchantVC = [[MerchantManagerViewController alloc] init];
            [self.navigationController pushViewController:merchantVC animated:YES];
        }
            break;
        case 3:
        {
            // 会员管理
            MembersManagerViewController *memberVC = [[MembersManagerViewController alloc] initWithNibName:@"MembersManagerViewController" bundle:nil];
            [self.navigationController pushViewController:memberVC animated:YES];
        }
            break;
        case 4:
        {
            // 投诉管理
            ComplainManagerController *complainController = [[ComplainManagerController alloc] init];
            [self.navigationController pushViewController:complainController animated:YES];
        }
            break;
        case 5:
        {
            // 平台公告
            NoticeController *noticeController = [[NoticeController alloc] init];
            [self.navigationController pushViewController:noticeController animated:YES];
        }
            break;
        case 6:
        {
            // 基本信息
            BaseInfoViewController *baseInfoVC = [[BaseInfoViewController alloc] initWithNibName:@"BaseInfoViewController" bundle:nil];
            [self.navigationController pushViewController:baseInfoVC animated:YES];
        }
            break;
        default:
            break;
    }

}




@end
