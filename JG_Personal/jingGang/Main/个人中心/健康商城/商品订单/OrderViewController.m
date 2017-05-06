//
//  OrderViewController.m
//  jingGang
//
//  Created by thinker on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OrderViewController.h"
#import "TLTitleSelectorView.h"
#import "Masonry.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "OrderCell.h"
#import "ApplySalesReturnVC.h"
#import "APIManager.h"
#import "OrderConfirmViewController.h"
#import "QueryLogisticsViewController.h"
#import "PayOrderViewController.h"
#import "ShopCenterListReformer.h"
#import "MJRefresh.h"
#import "ActionSheetStringPicker.h"
#import "OrderDetailController.h"
#import "KJDarlingCommentVC.h"
#import "MJExtension.h"
#import "NodataShowView.h"
#import "AppDelegate.h"

@interface OrderViewController () <UITableViewDataSource,UITableViewDelegate,APIManagerDelegate>

@property (weak, nonatomic) IBOutlet TLTitleSelectorView *titleSelector;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) ActionSheetStringPicker *actionPicker;
@property (nonatomic) NSMutableArray *dataSource;
@property (nonatomic) NSMutableArray *orderListArray;
@property (nonatomic) int pageNumber;
@property (nonatomic) BOOL hiddenSubviews;

@property (nonatomic) NSMutableArray<__kindof SelfOrder *> *selfOrderList;
@property (nonatomic) APIManager *selfOrderListManager;
@property (nonatomic) APIManager *orderCancelManage;
@property (nonatomic) APIManager *orderDeleteManage;
@property (nonatomic) APIManager *confirmRecieveManage;
@property (nonatomic) ShopCenterListReformer <AddressReformerProtocol> *shopCenterReformer;
@property (nonatomic) NSString *orderStatus;

@end

@implementation OrderViewController

//@synthesize dataSource = _dataSource;

static NSString const *cellIdentifier = @"OrderCell";

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad{
    
    [self setUIContent];
    [self setViewsMASConstraint];
    [self initResueqs];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView headerBeginRefreshing];
}


- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier.copy cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier.copy cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self showOrderDetailVC:[self getOrderID:indexPath]];
    [self showOrderDetailVC:[self getOrderID:indexPath] goodsInfo:[self getGoodsInfo:indexPath]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier.copy];
    
    [self loadCellContent:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    OrderCell *orderCell = (OrderCell *)cell;
    //这里把数据设置给Cell
    NSDictionary *orderData = self.dataSource[indexPath.row];
    [orderCell configWithReformedOrder:orderData];
    SelfOrder *selfOrder = self.selfOrderList[indexPath.row];
    [orderCell setgoodsViews:selfOrder.goodsInfos];
    [orderCell setAddTime:TNSString(selfOrder.addTime)];
    orderCell.indexPath = indexPath;
    if (!orderCell.isAssociatedAction) {
        orderCell.associatedAction = YES;
        orderCell.tapBlack = ^(NSIndexPath *indexPath) {
//            [self showOrderDetailVC:[self getOrderID:indexPath]];
            [self showOrderDetailVC:[self getOrderID:indexPath] goodsInfo:[self getGoodsInfo:indexPath]];
        };
        orderCell.buttonPressBlock = ^(TLOperationType operationType,NSIndexPath *indexPath) {
            [self pressCellButton:operationType atIndexPath:indexPath];
        };
    }
}

#pragma mark - APIManagerDelegate 网络回调
- (void)apiManagerDidSuccess:(APIManager *)manager {
    if (manager == self.selfOrderListManager) {
        if ([self.tableView isHeaderRefreshing]) {
            [self.tableView headerEndRefreshing];
        }
        if ([self.tableView isFooterRefreshing]) {
            [self.tableView footerEndRefreshing];
        }
        
        if (manager.successResponse != nil) {
            SelfOrderListResponse *response = (SelfOrderListResponse *)manager.successResponse;
            NSArray *orderList = response.orderList;
            if (orderList.count > 0) {
                [NodataShowView hideInContentView:self.tableView];
                for (NSDictionary *selfOrder in orderList) {
                    [self.dataSource addObject:[self.shopCenterReformer getOrderDatafromData:selfOrder fromManager:manager]];
                    [self.orderListArray addObject:selfOrder];
                }
                [SelfOrder setupObjectClassInArray:^NSDictionary *{
                    return @{
                             @"goodsInfos" : [GoodsInfo class]
                             };
                }];
                [SelfOrder setupReplacedKeyFromPropertyName:^NSDictionary *{
                    return @{@"apiId":@"id"};
                }];
                [self.selfOrderList addObjectsFromArray:[SelfOrder objectArrayWithKeyValuesArray:orderList]];
                self.pageNumber++;
                [self.tableView reloadData];
                [self setHiddenSubviews:NO];
            } else if (self.dataSource.count == 0 ) {
                [self showNoDataView];
            }
        }
    } else if (manager == self.orderCancelManage) {
        [self reloadOrderData];
    } else if (manager == self.confirmRecieveManage) {
        [self reloadOrderData];
    }
    
}

- (void)apiManagerDidFail:(APIManager *)manager {
    if ([self.tableView isHeaderRefreshing]) {
        [self.tableView headerEndRefreshing];
    }
    if ([self.tableView isFooterRefreshing]) {
        [self.tableView footerEndRefreshing];
    }
    NSLog(@"NSError: %@",manager.error);
}

#pragma mark - event response

- (void)showNoDataView {
//    NodataShowView *showView = [NodataShowView showInContentView:self.tableView withReloadBlock:^{
//        
//        AppDelegate *appDelegate = kAppDelegate;
//        [appDelegate gogogoWithTag:3];
//    } requestResultType:NoDataType];
//    [showView.alertButton setTitle:@"你还没有相关订单，可以看看有哪些想买的，随便去逛逛" forState:UIControlStateNormal];
    [NodataShowView showInContentView:self.tableView withReloadBlock:^{
        AppDelegate *appDelegate = kAppDelegate;
        [appDelegate gogogoWithTag:3];
    } alertTitle:@"你还没有相关订单，可以看看有哪些想买的，随便去逛逛"];
    
}

#pragma mark - 跳转至订单详情
- (void)showOrderDetailVC:(NSNumber *)ID goodsInfo:(NSArray *)goodsInfo{
    OrderDetailController *VC = [[OrderDetailController alloc] initWithNibName:@"OrderDetailController" bundle:nil];
    VC.orderID = ID;
    VC.goodsInfo = goodsInfo;
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - 取消订单
- (void)cancelOrderAction:(NSIndexPath *)indexPath
{
    __block NSString *cancelReason = @"不想要了";
    long orderID = [self getOrderID:indexPath].longValue;
    
    NSArray *numberData = @[
                            @"我不想要了",
                            @"信息错误,重新拍",
                            @"卖家缺货",
                            @"其他原因",
                            ];
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        cancelReason = selectedValue;
        [self.orderCancelManage cancelOrder:orderID stateInfo:cancelReason];
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
    };
    self.actionPicker = [[ActionSheetStringPicker alloc] initWithTitle:@"退货原因" rows:numberData.copy initialSelection:0 doneBlock:done cancelBlock:cancel origin:self.view];
    [self.actionPicker showActionSheetPicker];
}

#pragma mark - 删除订单
- (void)deleteOrder:(NSIndexPath *)index
{
    for (NSInteger i = 1; i < self.dataSource.count - index.row; i++) {
        NSIndexPath *loopIndex = [NSIndexPath indexPathForRow:index.row+i inSection:index.section];
        OrderCell *cell = (OrderCell *)[self.tableView cellForRowAtIndexPath:loopIndex];
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:index.row+i-1 inSection:index.section];
        cell.indexPath = newIndex;
    }
    [self.orderDeleteManage deleteOrder:[self getOrderID:index].longValue];
    [self.dataSource removeObjectAtIndex:index.row];
    [self.orderListArray removeObjectAtIndex:index.row];
    [self.selfOrderList removeObjectAtIndex:index.row];
    [self.tableView deleteRowsAtIndexPaths:@[index]
                          withRowAnimation:UITableViewRowAnimationLeft];
}

#pragma mark - 改变所选状态
- (void)changeSelectedTtile:(NSInteger)selectedNumber
{
    NSString *orderStatus = nil;
    if (1 == selectedNumber) {
        orderStatus = @"order_submit";
    } else if (2 == selectedNumber) {
        orderStatus = @"order_pay";
    } else if (3 == selectedNumber) {
        orderStatus = @"order_shipping";
    } else if (4 == selectedNumber) {
        orderStatus = @"order_receive";
    }
    self.orderStatus = orderStatus;
    self.selfOrderListManager = [[APIManager alloc] initWithDelegate:self];
    [self reloadOrderData];

}

#pragma mark - 响应订单的各种取消、查看物流、评价...等等事件
- (void)pressCellButton:(TLOperationType)operationType atIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *VC = nil;
    switch (operationType) {
        case TLOperationTypeCancel:
        {
            NSLog(@"[%lu - %lu] 取消订单",indexPath.section,indexPath.row);
            [self cancelOrderAction:indexPath];
            break;
        }
        case TLOperationTypeDelete:
            NSLog(@"[%lu - %lu] 删除订单",indexPath.section,indexPath.row);
            [self deleteOrder:indexPath];

            break;
            case TLOperationTypePay:
        {
            NSLog(@"[%lu - %lu] 支付",indexPath.section,indexPath.row);
            PayOrderViewController *payVC = [[PayOrderViewController alloc] initWithNibName:@"PayOrderViewController" bundle:nil];
            NSDictionary *orderData = self.dataSource[indexPath.row];
            payVC.orderID = ((NSNumber *)orderData[orderKeyID]);
            payVC.jingGangPay = ShoppingPay;
            payVC.totalPrice = ((NSNumber *)orderData[orderKeyTotalPrice]).floatValue;
            payVC.orderNumber = (NSString *)orderData[orderKeyOrderID];
            VC = payVC;
        }

            break;
            case TLOperationTypeRecieve:
            NSLog(@"[%lu - %lu] 签收商品",indexPath.section,indexPath.row);
            [self.confirmRecieveManage confirmRecieve:[self getOrderID:indexPath].longValue];
            
            break;
            case TLOperationTypeCheckLogistics:
        {
            NSLog(@"[%lu - %lu] 查看物流",indexPath.section,indexPath.row);
            QueryLogisticsViewController *quertVC = [[QueryLogisticsViewController alloc] initWithNibName:@"QueryLogisticsViewController" bundle:nil];
            NSDictionary *orderData = self.dataSource[indexPath.row];
            quertVC.expressCompanyId = (NSNumber *)orderData[transKeyCompanyID];
            quertVC.expressCode = orderData[transKeyShipCodeID];
            VC = quertVC;
        }
  
            break;
        case TLOperationTypeWriteComment:
        {
            NSLog(@"[%lu - %lu] 写评价",indexPath.section,indexPath.row);
            KJDarlingCommentVC *commentVC = [[KJDarlingCommentVC alloc] initWithNibName:@"KJDarlingCommentVC" bundle:nil];
            commentVC.goodsInfos = [self getGoodsInfo:indexPath];
            commentVC.orderID = [self getOrderID:indexPath];
            VC = commentVC;
        }
            
            break;
        case TLOperationTypeReturn:
        {
            NSLog(@"[%lu - %lu] 退货",indexPath.section,indexPath.row);
            ApplySalesReturnVC *returnVC = [[ApplySalesReturnVC alloc] initWithNibName:@"ApplySalesReturnVC" bundle:nil];
            VC = returnVC;
        }
            
            break;
        default:
            break;
    }

    if (VC) {
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


#pragma mark - private methods

- (void)initResueqs
{
    self.selfOrderListManager = [[APIManager alloc] initWithDelegate:self];
    self.orderCancelManage = [[APIManager alloc] initWithDelegate:self];
    self.orderDeleteManage = [[APIManager alloc] initWithDelegate:self];
    self.confirmRecieveManage = [[APIManager alloc] initWithDelegate:self];
}

- (void)reloadOrderData {
    self.pageNumber = 1;
    self.dataSource = [[NSMutableArray alloc] init];
    self.orderListArray = [[NSMutableArray alloc] init];
    self.selfOrderList = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
    [self.selfOrderListManager getOrderList:self.orderStatus pageNum:@(self.pageNumber)];
}

- (void)addOrderData {
    [self.selfOrderListManager getOrderList:self.orderStatus pageNum:@(self.pageNumber)];
}

#pragma mark - 设置更新订单的操作
- (void)setRefresh {
    [self.tableView addHeaderWithCallback:^{
        if ([self.tableView isHeaderRefreshing]) {
            return;
        }
        [self reloadOrderData];
    }];
    [self.tableView addFooterWithCallback:^{
        if ([self.tableView isFooterRefreshing]) {
            return;
        }
        [self addOrderData];
    }];
}

- (void)tableViewInit {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 95.5;
    self.tableView.rowHeight = 95.5;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UINib *nibCell = [UINib nibWithNibName:@"OrderCell" bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier.copy];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)setBarButtonItem {
    [self setLeftBarAndBackgroundColor];
}

- (void)setUIContent
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self setBarButtonItem];
    self.title = @"商品订单";
    [self.titleSelector setSelectorTitles:@"全部",@"待付款",@"待发货",@"待收货",@"待评价",nil];
    self.titleSelector.backgroundColor = [UIColor whiteColor];
    self.titleSelector.buttonPressBlock = ^(NSInteger index) {
        NSLog(@"The %luth pressed",index);
        [self changeSelectedTtile:index];
    };
    [self tableViewInit];
    [self setRefresh];
    self.tableView.fd_debugLogEnabled = YES;
}

- (void)setViewsMASConstraint
{
    UIView *superView = self.view;
    [self.titleSelector mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.top.equalTo(superView.mas_top);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleSelector.mas_bottom);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(superView);
    }];
}

#pragma mark - getters and settters

- (NSArray *)getGoodsInfo:(NSIndexPath *)indexPath
{
    NSDictionary *selfOrder = self.orderListArray[indexPath.row];
    NSArray *goodsInfo = selfOrder[@"goodsInfos"];

    return goodsInfo;
}

- (NSNumber *)getOrderID:(NSIndexPath *)indexPath
{
    NSDictionary *orderData = self.dataSource[indexPath.row];
    NSNumber *orderID = ((NSNumber *)orderData[orderKeyID]);
    return orderID;
}

- (void)setOrderStatus:(NSString *)orderStatus {
    if (![_orderCancelManage isEqual:orderStatus]) {
        self.pageNumber = 1;
        self.dataSource = [[NSMutableArray alloc] init];
        self.orderListArray = [[NSMutableArray alloc] init];
        self.selfOrderList = [[NSMutableArray alloc] init];
        _orderStatus = orderStatus;
    }
}

- (void)setHiddenSubviews:(BOOL)hiddenSubviews {
    if (hiddenSubviews != _hiddenSubviews) {
        _hiddenSubviews = hiddenSubviews;
        self.tableView.hidden = hiddenSubviews;
    }
}


- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

- (ShopCenterListReformer *)shopCenterReformer {
    if (_shopCenterReformer == nil) {
        _shopCenterReformer = [[ShopCenterListReformer alloc] init];
    }
    return _shopCenterReformer;
}

#pragma mark - dyci debug operation
- (void)updateOnClassInjection {
//    [self showNoDataView];
    UIViewController *VC = [[NSClassFromString(@"ApplySalesReturnVC") alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
