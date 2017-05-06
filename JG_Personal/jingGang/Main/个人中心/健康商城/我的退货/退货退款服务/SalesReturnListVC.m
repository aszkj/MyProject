//
//  SalesReturnListVC.m
//  JingGangIB
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "SalesReturnListVC.h"
#import "PublicInfo.h"
#import "SalesReturnListTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "SalesReturnDetailVC.h"
#import "Masonry.h"
#import "APIManager.h"
#import "MJRefresh.h"
#import "ShopCenterListReformer.h"
#import "MBProgressHUD.h"

@interface SalesReturnListVC () <UITableViewDelegate,UITableViewDataSource,APIManagerDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataSource;
@property (nonatomic) NSInteger pageNum;
@property (nonatomic) NSInteger totalPage;
@property (nonatomic) ShopCenterListReformer *returnReformer;
@property (nonatomic) APIManager *returnListManager;
@property (nonatomic) APIManager *cancelReturnManager;
@property (nonatomic) APIManager *companyListManager;
@property (nonatomic) MBProgressHUD *progressHUD;

@end

@implementation SalesReturnListVC

static NSString *cellIdentifier = @"SalesReturnListTableViewCell";

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    
    [self.view addSubview:self.tableView];
    [self setUIContent];
    [self setViewsMASConstraint];
    self.returnListManager = [[APIManager alloc] initWithDelegate:self];
    self.cancelReturnManager = [[APIManager alloc] initWithDelegate:self];
    self.companyListManager = [[APIManager alloc] initWithDelegate:self];
    [self.companyListManager getWuliuCompanyList];
    self.returnReformer = [[ShopCenterListReformer alloc] init];
    [self setRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidAppear:(BOOL)animated {
    self.dataSource = [[NSMutableArray alloc] init];
    [self.tableView headerBeginRefreshing];

}

- (void)viewWillDisappear:(BOOL)animate {
    
    
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];
        
    }];
}

- (CGFloat)getCellHeight:(UITableViewCell*)cell
{
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];
        
    }];}


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
    SalesReturnListTableViewCell *mycell = (SalesReturnListTableViewCell *)cell;
    [mycell configWithReformedOrder:(NSDictionary *)self.dataSource[indexPath.row]];
    
    if (mycell.indexPath == nil) {
        mycell.buttonPressBlock = ^(TLSalesReturnStatus salesReturnStatus,NSIndexPath *indexPath) {
            [self cellButtonAction:indexPath status:salesReturnStatus];
        };
    }
    mycell.indexPath = indexPath;
}

#pragma mark - 网络请求处理
- (void)apiManagerDidSuccess:(APIManager *)manager
{
    if (self.returnListManager == manager) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self.progressHUD hide:YES];

        ShopTradeReturnListResponse *response = (ShopTradeReturnListResponse *)manager.successResponse;
        self.totalPage = response.totalPage.integerValue;
        if (self.pageNum <= self.totalPage) {
            self.pageNum++;
        } else {
            return;
        }
        
        for (NSDictionary *returnDic in response.list) {
            [self.dataSource addObject:[self.returnReformer getReturnDicfromData:returnDic]];
        }
        [self.tableView reloadData];

    } else if (manager == self.cancelReturnManager) {
        [self.returnListManager getReturnList:self.pageNum];
    } else if (manager == self.companyListManager) {
        
    }
}
- (void)apiManagerDidFail:(APIManager *)manager
{
    if (manager == self.cancelReturnManager) {
        [self.progressHUD hide:YES];

    }
}

#pragma mark - 设置更新退货列表的操作
- (void)setRefresh {
    
    self.pageNum = 1, self.totalPage = 1;
    __weak __typeof(&*self)weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.dataSource = [[NSMutableArray alloc] init];
        [weakSelf.tableView reloadData];
        weakSelf.pageNum = 1;
        [weakSelf.returnListManager getReturnList:weakSelf.pageNum];
    }];
    [self.tableView addFooterWithCallback:^{
        if (weakSelf.pageNum > weakSelf.totalPage) {
            [weakSelf.tableView footerEndRefreshing];
        } else {
            [weakSelf.returnListManager getReturnList:weakSelf.pageNum];
        }
    }];
    
}

#pragma mark - event response

- (void)deleteRecord:(NSIndexPath *)index
{
    for (NSInteger i = 1; i < self.dataSource.count - index.row; i++) {
        NSIndexPath *loopIndex = [NSIndexPath indexPathForRow:index.row+i inSection:index.section];
        SalesReturnListTableViewCell *returnCell = (SalesReturnListTableViewCell *)[self.tableView cellForRowAtIndexPath:loopIndex];
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:index.row+i-1 inSection:index.section];
        returnCell.indexPath = newIndex;
    }
    
    [self.dataSource removeObjectAtIndex:index.row];
    [self.tableView deleteRowsAtIndexPaths:@[index]
                          withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)cancelReturnAction:(NSIndexPath *)index
{
    NSDictionary *returnDic = self.dataSource[index.row];
    long orderId = ((NSNumber *)returnDic[returnGoodsKeyOrderId]).longValue;
    long goodsId = ((NSNumber *)returnDic[returnGoodsKeyGoodsId]).longValue;
    NSString *gspIds = (NSString *)returnDic[returnGoodsKeyGoodsGspIds];
    [self.cancelReturnManager cancelReturnOrderID:orderId goodsID:goodsId goodsGspIds:gspIds];
    
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Loading";
    [self.progressHUD show:YES];
}

- (void)cellButtonAction:(NSIndexPath *)index status:(TLSalesReturnStatus)salesReturnStatus
{
    //TODO:填写物流待测试，删除退货待服务器添加
    NSDictionary *returnDic = self.dataSource[index.row];
    if (TLSalesReturnStatusWaitCheck == salesReturnStatus) {
        [self cancelReturnAction:index];
    } else if (TLSalesReturnStatusWaitWrite == salesReturnStatus) {
        SalesReturnDetailVC *vc = [[SalesReturnDetailVC alloc] init];
        [vc setGoodsName:returnDic[returnGoodsKeyGoodsName]];
        [vc setReturnReason:returnDic[returnGoodsKeyReason]];
        [vc setRecieveAddress:returnDic[returnGoodsKeyselfAddress]];
        [vc setCompanyList:[self companyListArray]];
        vc.returnGoodsLogId = returnDic[returnGoodsKeyLogId];
        [self.navigationController pushViewController:vc animated:YES];

    } else if (TLSalesReturnStatusWaitMoney == salesReturnStatus) {
        
    } else if (TLSalesReturnStatusGetMoney == salesReturnStatus) {
        [self cancelReturnAction:index];
        
    } else if (TLSalesReturnStatusCheckFail == salesReturnStatus) {
//        [self deleteRecord:index];
        [self cancelReturnAction:index];
    }
    
}

#pragma mark - private methods

- (void)setBarButtonItem {
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain  target:self  action:nil];
//    self.navigationItem.backBarButtonItem = backButton;
    [self setLeftBarAndBackgroundColor];
}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)setUIContent {
    [self setNavigationBar];
    [self setBarButtonItem];
    [self addBackButtonIfNeed];
    self.title = @"商品退货";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setViewsMASConstraint {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}

#pragma mark - getters and settters

- (NSArray *)companyListArray {
    NSArray *result = nil;
    if (self.companyListManager.successResponse != nil) {
        ShopExpressCompanyListResponse *response = self.companyListManager.successResponse;
        result = response.list;
    }
    return result;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 95.5;
        _tableView.rowHeight = 95.5;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UINib *nibCell = [UINib nibWithNibName:@"SalesReturnListTableViewCell" bundle:nil];
        [_tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _tableView;
}


#pragma mark - debug operation
- (void)updateOnClassInjection {
    
}



@end
