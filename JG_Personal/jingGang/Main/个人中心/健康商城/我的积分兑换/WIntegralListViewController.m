//
//  WIntegralListViewController.m
//  jingGang
//
//  Created by thinker on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WIntegralListViewController.h"
#import "MJRefresh.h"
#import "WIntegralListTableViewCell.h"
#import "MJExtension.h"
#import "PayOrderViewController.h"
#import "MBProgressHUD.h"
#import "WMERSearchViewController.h"
#import "IntegralDetailViewController.h"

@interface WIntegralListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    double _UserIntegral;//用户剩余的积分
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;


@end

NSString *const integralListCell = @"WIntegralListTableViewCell";

@implementation WIntegralListViewController

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WIntegralListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:integralListCell];
    OrderListBO *orderList;
    if (indexPath.row < self.dataSource.count)
    {
        orderList = self.dataSource[indexPath.row];
        cell.data = orderList;
    }
    WEAK_SELF
    //TODO:取消
    cell.cancelAction = ^(){
        NSLog(@"cancel ---- %ld",indexPath.row);
        [weak_self cancelOrderWithOrder:orderList withIndexPath:indexPath];
    };
    //TODO:确定收货
    cell.certainAction = ^(){
        NSLog(@"certain ---- %ld",indexPath.row);
        [weak_self certainOrderWithOrder:orderList withIndexPath:indexPath];
    };
    //TODO:付款
    cell.payAction = ^(){
        NSLog(@"pay ---- %ld",indexPath.row);
        if (orderList.igoTotalIntegral.doubleValue > _UserIntegral) {
            [Util ShowAlertWithOnlyMessage:@"您好！您的积分金额不足..."];
            return ;
        }
        PayOrderViewController *payVC = [[PayOrderViewController alloc] initWithNibName:@"PayOrderViewController" bundle:nil];
        payVC.orderID = orderList.apiId;
        payVC.orderNumber = orderList.igoOrderSn;
        payVC.totalPrice = orderList.igoTransFee.doubleValue;
        payVC.jingGangPay = IntegralPay;
        [weak_self.navigationController pushViewController:payVC animated:YES];
    };
    //TODO:积分商品事件
    cell.shopAction = ^(NSDictionary *dict){
        NSLog(@"商品信息 ---- %@",dict);
    };
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderListBO *list = self.dataSource[indexPath.row];
    IntegralDetailViewController *orderDetailVC = [[IntegralDetailViewController alloc] initWithNibName:@"IntegralDetailViewController" bundle:nil];
    orderDetailVC.orderId = list.apiId;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.dataSource.count)
    {
        OrderListBO *list = self.dataSource[indexPath.row];
        return 132 + 90 * list.orderBOList.count;
    }
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark - 网络请求数据
- (void)requestData
{
    IntegralOrderListRequest *orderList = [[IntegralOrderListRequest alloc] init:GetToken];
    orderList.api_pageNum = @(_page);
    orderList.api_pageSize = @(10);
    WEAK_SELF
    [self.vapiManager integralOrderList:orderList success:^(AFHTTPRequestOperation *operation, IntegralOrderListResponse *response) {
        NSLog(@"response ---- %@",response);
        for (NSDictionary *dict in response.orderList) {
            OrderListBO *list = [OrderListBO objectWithKeyValues:dict];
            [list setValue:dict[@"id"] forKey:@"apiId"];
            [weak_self.dataSource addObject:list];
        }
        [weak_self.tableView reloadData];
        [weak_self.tableView headerEndRefreshing];
        [weak_self.tableView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error ---- %@",error);
        [weak_self errorHandle:error];
        [weak_self.tableView headerEndRefreshing];
        [weak_self.tableView footerEndRefreshing];
    }];
}
#pragma mark - 取消订单
/**
 *  取消订单
 *
 *  @param orderList 订单对象
 *  @param indexPath 哪一行
 */
- (void)cancelOrderWithOrder:(OrderListBO *)orderList withIndexPath:(NSIndexPath *)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud show:YES];
    IntegralCancelRequest *cancelRequest = [[IntegralCancelRequest alloc] init:GetToken];
    cancelRequest.api_id = orderList.apiId;
    WEAK_SELF
    [self.vapiManager integralCancel:cancelRequest success:^(AFHTTPRequestOperation *operation, IntegralCancelResponse *response) {
        NSLog(@"取消订单成功 ---- %@",response);
        [orderList setValue:@(-1) forKey:@"igoStatus"];//修改列表的状态
        [weak_self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"取消订单失败 ---- %@",error);
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        [weak_self errorHandle:error];
    }];
}
#pragma mark - 确认收货
/**
 *  确认收货
 *
 *  @param orderList 订单对象
 *  @param indexPath 哪一行
 */
- (void)certainOrderWithOrder:(OrderListBO *)orderList withIndexPath:(NSIndexPath *)indexPath
{
    WEAK_SELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud show:YES];
    IntegralOrderCofirmRequest *cofirmRequest = [[IntegralOrderCofirmRequest alloc] init:GetToken];
    cofirmRequest.api_id = orderList.apiId;
    [self.vapiManager integralOrderCofirm:cofirmRequest success:^(AFHTTPRequestOperation *operation, IntegralOrderCofirmResponse *response) {
        NSLog(@"取消订单成功 ---- %@",response);
        [orderList setValue:@(40) forKey:@"igoStatus"];//修改列表的状态
        [weak_self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"确认订单失败 ---- %@",error);
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        [weak_self errorHandle:error];
    }];
}
#pragma mark - 查询用户积分
-(void)getUserIntegral
{
    UsersIntegralGetRequest *request = [[UsersIntegralGetRequest alloc] init:GetToken];
    [self.vapiManager usersIntegralGet:request success:^(AFHTTPRequestOperation *operation, UsersIntegralGetResponse *response) {
        NSDictionary *integralDic = (NSDictionary *)response.integral;
        if (integralDic) {
            _UserIntegral = [integralDic[@"integral"] doubleValue];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - 实例化UI
- (void)initUI
{
    [Util setNavTitleWithTitle:@"兑换订单" ofVC:self];
    self.dataSource = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIntegralListTableViewCell" bundle:nil] forCellReuseIdentifier:integralListCell];
    self.tableView.tableFooterView = [UIView new];
    WEAK_SELF
    [self.tableView addHeaderWithCallback:^{
        weak_self.page = 1;
        [weak_self.dataSource removeAllObjects];
        [weak_self requestData];
    }];
    [self.tableView addFooterWithCallback:^{
        weak_self.page += 1;
        [weak_self requestData];
    }];
    [self.tableView headerBeginRefreshing];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserIntegral];
}
@end
