//
//  JGHealthStoreController.m
//  jingGang
//
//  Created by HanZhongchou on 16/1/20.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGHealthStoreController.h"
#import "OrderViewController.h"
#import "WIntegralListViewController.h"
#import "SalesReturnListVC.h"
#import "WSJManagerAddressViewController.h"
#import "JGCouponViewController.h"
@interface JGHealthStoreController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *arrayTitleData;
@end

@implementation JGHealthStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"健康商城";
    
    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}
- (NSArray *)arrayTitleData
{
    if (!_arrayTitleData) {
        _arrayTitleData = [NSArray arrayWithObjects:@"商品订单",@"兑换订单", @"商品退货",@"优惠券",@"收货地址",nil];
    }
    return _arrayTitleData;
}
#pragma mark ---UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayTitleData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifile = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifile];
    }
    
    cell.textLabel.text = self.arrayTitleData[indexPath.row];
    return cell;
}


#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *controller;
    if (indexPath.row == 0) {//商品订单
        OrderViewController *GoodsOrderVC = [[OrderViewController alloc]init];
        controller = GoodsOrderVC;
    }else if (indexPath.row == 1){//兑换订单
        WIntegralListViewController *WIntegralListVC = [[WIntegralListViewController alloc]init];
        controller = WIntegralListVC;
    }else if (indexPath.row == 2){//商品退货
        SalesReturnListVC *salesReturnListVC = [[SalesReturnListVC alloc]init];
        controller = salesReturnListVC;
    }else if (indexPath.row == 3){//优惠券
        JGCouponViewController *JGCouponVC = [[JGCouponViewController alloc]init];
        controller = JGCouponVC;
    }else if (indexPath.row == 4){//收货地址
        WSJManagerAddressViewController *WSJManagerAddressVC = [[WSJManagerAddressViewController alloc]init];
        controller = WSJManagerAddressVC;
    }
    [self.navigationController pushViewController:controller animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
