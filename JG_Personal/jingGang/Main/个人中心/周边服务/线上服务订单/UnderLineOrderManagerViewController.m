//
//  UnderLineOrderManagerViewController.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "UnderLineOrderManagerViewController.h"
#import "TLTitleSelectorView.h"
#import "PublicInfo.h"
#import "Masonry.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "APIManager.h"
#import "MJRefresh.h"
#import "UnderLineOrderManagerTableViewCell.h"
#import "NodataShowView.h"
#import "MJExtension.h"
#import "ShoppingOrderDetailController.h"
#import "PayOrderViewController.h"
#import "ServiceCommentController.h"
#import "AppDelegate.h"

@interface UnderLineOrderManagerViewController () <UITableViewDelegate,UITableViewDataSource,APIManagerDelegate>

@property (nonatomic) TLTitleSelectorView *titleView;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataSource;
@property (nonatomic) int pageNumber;
@property (nonatomic) BOOL hiddenSubviews;

@property (nonatomic) APIManager *orderLineListManager;
@property (nonatomic) APIManager *orderCancelManage;
@property (nonatomic) APIManager *orderPayViewManager;
@property (nonatomic) NSInteger orderStatus;

@end

static NSString *cellIdentifier = @"UnderLineOrderManagerTableViewCell";

@implementation UnderLineOrderManagerViewController
@synthesize orderStatus = _orderStatus;

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableView];
    
    [self setUIContent];
    [self setViewsMASConstraint];
    self.orderLineListManager = [[APIManager alloc] initWithDelegate:self];
    self.orderCancelManage = [[APIManager alloc] initWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView headerBeginRefreshing];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyselfGroupOrder *groupOrder = self.dataSource[indexPath.row];
    ShoppingOrderDetailController *VC = [[ShoppingOrderDetailController alloc] initWithStatus:self.orderStatus];
    VC.orderId = groupOrder.apiId.integerValue;
    [self.navigationController pushViewController:VC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)getHeightTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    
    [self loadCellContent:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    //这里把数据设置给Cell
    UnderLineOrderManagerTableViewCell *underOrderCell = (UnderLineOrderManagerTableViewCell *)cell;
    [underOrderCell configWithObject:self.dataSource[indexPath.row]];
    underOrderCell.payBlock = ^() {
        [self payOrder:[self.tableView indexPathForCell:cell]];
    };
    underOrderCell.commentBlock = ^() {
        [self commnent:[self.tableView indexPathForCell:cell]];
    };
    underOrderCell.cancelBlock = ^() {
        [self cancelOrder:[self.tableView indexPathForCell:cell]];
    };
}

#pragma mark - 处理网络返回
- (void)apiManagerDidSuccess:(APIManager *)manager {
    [NodataShowView hideInContentView:self.tableView];
    if (manager == self.orderLineListManager) {
        if ([self.tableView isHeaderRefreshing]) {
            [self.tableView headerEndRefreshing];
        }
        if ([self.tableView isFooterRefreshing]) {
            [self.tableView footerEndRefreshing];
        }
        
        if (manager.successResponse != nil) {
            PersonalGroupOrderListResponse *response = (PersonalGroupOrderListResponse *)manager.successResponse;
            NSMutableArray *dicArray = [NSMutableArray array];
            [response.myselfOrderList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * stop) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:obj];
                [dic setObject:obj[@"id"] forKey:@"apiId"];
                [dicArray addObject:dic];
            }];
            NSArray *orderArray = [MyselfGroupOrder objectArrayWithKeyValuesArray:dicArray];
            if ([manager.name isEqualToString:@"lowerFresh"]) {
                self.dataSource = [NSMutableArray array];
                [self.tableView setScrollsToTop:YES];
            }
            [self.dataSource addObjectsFromArray:orderArray];
            if (orderArray.count > 0) { self.pageNumber++;}
            [self.tableView reloadData];
            if (self.dataSource.count == 0) {
                NodataShowView *showView = [NodataShowView showInContentView:self.tableView withReloadBlock:^{
                    
                    AppDelegate *appDelegate = kAppDelegate;
                    [appDelegate gogogoWithTag:3];
                } requestResultType:NoDataType];
                [showView.alertButton setTitle:@"您还没有相关订单，可以去看看有哪些想买的，随便逛逛" forState:UIControlStateNormal];
            }
        } else {
            
        }
    } else if (manager == self.orderCancelManage) {
        [self reloadOrderData];
    } else if (manager == self.orderPayViewManager) {
        PersonalPayViewResponse *response = (PersonalPayViewResponse *)manager.successResponse;
        GroupOrder *orderView = [GroupOrder objectWithKeyValues:response.order];
        PayOrderViewController *VC = [[PayOrderViewController alloc] initWithNibName:@"PayOrderViewController" bundle:nil];
        VC.orderNumber = orderView.orderId;
        VC.totalPrice = orderView.totalPrice.doubleValue;
        VC.orderID = ((NSDictionary *)response.order)[@"id"];
        VC.jingGangPay = O2OPay;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (void)apiManagerDidFail:(APIManager *)manager {
    if ([self.tableView isHeaderRefreshing]) {
        [self.tableView headerEndRefreshing];
    }
    if ([self.tableView isFooterRefreshing]) {
        [self.tableView footerEndRefreshing];
    }
    [NodataShowView showInContentView:self.tableView withReloadBlock:nil requestResultType:NetworkRequestFaildType];
}


#pragma mark - event response

- (void)cancelOrder:(NSIndexPath *)indexPath {
    MyselfGroupOrder *groupOrder = self.dataSource[indexPath.row];
    [self.orderCancelManage orderRefund:groupOrder.apiId];
    [NodataShowView showLoadingInView:self.tableView];
}

- (void)payOrder:(NSIndexPath *)indexPath {
    [NodataShowView showLoadingInView:self.tableView];
    MyselfGroupOrder *groupOrder = self.dataSource[indexPath.row];
    self.orderPayViewManager = [[APIManager alloc] initWithDelegate:self];
    [self.orderPayViewManager personalPayView:groupOrder.apiId];
}

- (void)commnent:(NSIndexPath *)indexPath {
    ServiceCommentController *VC = [[ServiceCommentController alloc] initWithNibName:@"ServiceCommentController" bundle:nil];
    VC.groupOrder = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)changeSelectedTtile:(NSInteger)index {
    if (index == 0) {
        self.orderStatus = 20;
    } else if (index == 1) {
        self.orderStatus = 10;
    } else if (index == 2) {
        self.orderStatus = 30;
    } else if (index == 3) {
        self.orderStatus = 0;
    } else if (index == 4) {
        self.orderStatus = 100;
    }
    [self reloadOrderData];
}

#pragma mark - private methods
- (void)reloadOrderData {
    self.pageNumber = 1;
    self.orderLineListManager = [[APIManager alloc] initWithDelegate:self];
    self.orderLineListManager.name = @"lowerFresh";
    [self.orderLineListManager getPersonalGroupOrderStatus:self.orderStatus pageSize:10 pageNum:self.pageNumber];
}

- (void)addOrderData {
    self.orderLineListManager = [[APIManager alloc] initWithDelegate:self];
    self.orderLineListManager.name = @"upperFresh";
    [self.orderLineListManager getPersonalGroupOrderStatus:self.orderStatus pageSize:10 pageNum:self.pageNumber];
}

#pragma mark - 设置更新订单的操作
- (void)setRefresh {
    WEAK_SELF
    [self.tableView addHeaderWithCallback:^{
        if ([weak_self.tableView isHeaderRefreshing]) {
            return;
        }
        [weak_self reloadOrderData];
    }];
    [self.tableView addFooterWithCallback:^{
        if ([weak_self.tableView isFooterRefreshing]) {
            return;
        }
        [weak_self addOrderData];
    }];
}

- (void)tableViewInit {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 95.5;
    self.tableView.rowHeight = 95.5;
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier.copy];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setBarButtonItem {
    [self setLeftBarAndBackgroundColor];
}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    navBar.backgroundColor = status_color;
}

- (void)setUIContent {
    [self setNavigationBar];
    [self setBarButtonItem];
    [self tableViewInit];
    [self setRefresh];

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"线上服务订单";
    self.orderStatus = 20;
}

- (void)setViewsMASConstraint {
    UIView *superView = self.view;
    [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(superView);
        make.height.equalTo(@(42));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(superView);
    }];
}

#pragma mark - getters and settters

- (void)setOrderStatus:(NSInteger)orderStatus {
    if (orderStatus != _orderStatus) {
        _orderStatus = orderStatus;
    }
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (TLTitleSelectorView *)titleView {
    if (_titleView == nil) {
        _titleView = [[TLTitleSelectorView alloc] initWithTitles:@"未消费",@"待付款",@"已完成",@"已取消",@"已退款", nil];
        _titleView.backgroundColor = [UIColor whiteColor];
        WEAK_SELF;
        _titleView.buttonPressBlock = ^(NSInteger index) {
            [weak_self changeSelectedTtile:index];
        };
    }
    return _titleView;
}


#pragma mark - debug operation
- (void)updateOnClassInjection {
    
}


@end
