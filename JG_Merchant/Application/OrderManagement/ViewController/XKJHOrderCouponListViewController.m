//
//  WSJOrderCouponListViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOrderCouponListViewController.h"
#import "XKJHOrderCouponDetailsViewController.h"
#import "XKJHMemberLIitViewController.h"
#import "XKJHConsumeViewController.h"
#import "XKJHShopEnterInfoViewController.h"
#import "XKJHCouponDetailsViewController.h"
#import "XKJHOnlineOrderIncomeDetailController.h"
#import "XKJHOfflineOrderManageController.h"
#import "VApiManager.h"
#import "XKJHTheDetailController.h"

#import "AppDelegate.h"
#import "XKJHRootController.h"

@interface XKJHOrderCouponListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    VApiManager *_vapiManager;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

static NSString *orderCouponCell = @"orderCouponCell";

@implementation XKJHOrderCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.tabBarController.tabBar.hidden = NO;
//}

- (void)requestData
{
    
    GroupGroupClassListRequest *request = [[GroupGroupClassListRequest alloc ]init:GetToken];
    [_vapiManager groupGroupClassList:request success:^(AFHTTPRequestOperation *operation, GroupGroupClassListResponse *response) {
        NSLog(@"cheshi ---- %@",response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"cheshi ---- %@",error);
    }];
    
    [self.dataSource addObject:@"线上服务订单管理"];
    [self.dataSource addObject:@"线上服务退款管理"];
    [self.dataSource addObject:@"线下刷卡订单管理"];

    [self.tableView reloadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCouponCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderCouponCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.textColor = UIColorFromRGB(0X666666);
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIViewController *vc = nil;

    self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;

    switch (indexPath.row)
    {
        case 0:
        {
            XKJHOnlineOrderIncomeDetailController *onlineOrderManageVC = [[XKJHOnlineOrderIncomeDetailController alloc] init];
            vc = onlineOrderManageVC;
        }
            break;
        case 1:
        {
            XKJHTheDetailController *onlineServiceRefundVC = [[XKJHTheDetailController alloc] init];
            onlineServiceRefundVC.theDetailType = OnlineServiceRefundType;
            vc = onlineServiceRefundVC;
        }
            break;
        case 2:
        {
            XKJHOfflineOrderManageController *offlineOrderManageVC = [[XKJHOfflineOrderManageController alloc] init];
            vc = offlineOrderManageVC;

        }
            break;
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initUI
{
    _vapiManager = [[VApiManager alloc] init];
    [Util setNavTitleWithTitle:@"订单管理" ofVC:self];
    self.view.backgroundColor = VCBackgroundColor;
    
    self.navigationController.navigationBar.barTintColor = status_color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.dataSource = [NSMutableArray array];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:orderCouponCell];
    self.tableView.rowHeight = 49;
    self.tableView.tableFooterView = [UIView new];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
//    self.navigationController.tabBarController.tabBar.hidden = NO;
}

#pragma mark - dyci debug operation
- (void)updateOnClassInjection {
    [self initUI];
    [self requestData];
}

@end
