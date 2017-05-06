
//
//  OffLineOrderController.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OffLineOrderController.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "urlManagerHeader.h"
#import "OffLineOrderCell.h"
#import "UIScrollView+MJRefresh.h"
#import "ShoppingOrderDetailController.h"
#import "MJExtension.h"
#import "PersonalOrderlineModel.h"
#import "PersonalOrderlineCell.h"

@interface OffLineOrderController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,strong) VApiManager *vapManager;
@property (assign, nonatomic) NSInteger currentPage;

@end

@implementation OffLineOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];

    CGRect frame = CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    _tableView.contentOffset = CGPointMake(0, 0);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    WEAK_SELF
    [_tableView addHeaderWithCallback:^{
        weak_self.currentPage = 1;
        [weak_self _requestPersonalOrderLineList];
    }];
    
    [_tableView addFooterWithCallback:^{
        [weak_self _requestPersonalOrderLineList];
    }];
    
    //开始自动刷新
    [self _autoFresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methord
#pragma mark- 初始化UI界面

- (void)initUI
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(goBack) target:self];

    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    [self _loadTitleView];
}

#pragma mark - 开始自动刷新
-(void)_autoFresh {
    //开始自动刷新
    self.currentPage = 1;
    [self.tableView headerBeginRefreshing];
}

-(void)_loadTitleView{
    
//    [Util setTitleViewWithTitle:@"我的线下刷卡订单" andNav:self.navigationController];
    self.title = @"线下服务订单";
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

#pragma mark - 数据请求下来之后，停止上下拉刷新，刷新表等
- (void)updateDatasource:(NSArray *)data {

    if (_currentPage == 1) {
        [self.tableView headerEndRefreshing];
    } else {
        [self.tableView footerEndRefreshing];
    }
    
    if (data && data.count > 0) {
        
        if (_currentPage == 1) {
            self.dataSource = [NSMutableArray arrayWithArray:data];
        } else {
            [self.dataSource addObjectsFromArray:data];
        }
        [self.tableView reloadData];
        
        _currentPage ++;
    }
}

#pragma mark- 导航返回
-(void)goBack
{
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9.9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalOrderlineCell *cell = [PersonalOrderlineCell personalOrderCellWithTableView:tableView];
    cell.orderlineModel =  self.dataSource[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PersonalOrderlineModel *orderlineModel = self.dataSource[indexPath.section];
    
    ShoppingOrderDetailController *orderDetail = [[ShoppingOrderDetailController alloc] init];
    orderDetail.orderId = orderlineModel.idType;
    
    [self.navigationController pushViewController:orderDetail animated:YES];
}

#pragma getter

- (VApiManager *)vapManager
{
    if (!_vapManager) {
        _vapManager = [[VApiManager alloc] init];
    }
    return _vapManager;
}


#pragma mark - 接口请求

#pragma mark - 个人线下订单列表接口
-(void)_requestPersonalOrderLineList{
    
    PersonalOrderLineListRequest *request = [[PersonalOrderLineListRequest alloc] init:GetToken];
    
    request.api_orderType = [NSNumber numberWithInteger:self.orderType];
    request.api_pageNum = [NSNumber numberWithInteger:self.currentPage];
    request.api_pageSize = [NSNumber numberWithInteger:10];
    
    [self.vapManager personalOrderLineList:request success:^(AFHTTPRequestOperation *operation, PersonalOrderLineListResponse *response) {
        
        NSArray *listArray = [NSArray arrayWithArray:response.myselfOrderLineList];
        if (listArray.count) {
            NSMutableArray *orderlineArray = [NSMutableArray array];
            for (int i = 0 ; i < listArray.count; i++) {
                NSDictionary *modelDic = listArray[i];
                
                PersonalOrderlineModel *orderlineModel = [PersonalOrderlineModel objectWithKeyValues:modelDic];
                [orderlineArray addObject:orderlineModel];
            }
            [self updateDatasource:orderlineArray];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self updateDatasource:nil];
    }];
}

@end
