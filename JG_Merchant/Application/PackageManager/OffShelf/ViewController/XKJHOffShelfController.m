//
//  XKJHOffShelfController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOffShelfController.h"
#import "XKJHPackageManagerCell.h"
#import "XKJHServiceDetailController.h"
#import "NSString+BlankString.h"
#import "NodataShowView.h"

@interface XKJHOffShelfController ()
@property (nonatomic, strong) NodataShowView *noDataView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,strong) VApiManager *vapManager;
@property (assign, nonatomic) NSInteger currentPage;
@property(nonatomic,strong) NSString *goodsId;
@property(nonatomic,strong) NSIndexPath *currentIndexPath;

@end

@implementation XKJHOffShelfController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化数据源
    self.dataSource = [[NSMutableArray alloc] init];
    
    [self _initTable];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(shelfChanged:)
                   name:kNotificationAddShelfChanged
                 object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private Method

- (void)_initTable {
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight - kNavBarAndStatusBarAndTopBarHeight);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.delaysContentTouches = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    _tableView.contentOffset = CGPointMake(0, 0);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.tableHeaderView = [self getHeaderView];
    _tableView.backgroundColor = background_Color;
    [self.view addSubview:_tableView];
    
    WEAK_SELF
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.currentPage = 1;
        [weak_self.tableView.footer resetNoMoreData];
        [weak_self _requestTableData];
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weak_self _requestTableData];
        
    }];
    
    //开始自动刷新
    [self _autoFresh];}

- (VApiManager *)vapManager
{
    if (!_vapManager) {
        _vapManager = [[VApiManager alloc] init];
    }
    return _vapManager;
}

- (void)shelfChanged:(NSNotification *)n {
    [self _autoFresh];
}

#pragma mark - 开始自动刷新
-(void)_autoFresh {
    //开始自动刷新
    self.currentPage = 1;
    [self.tableView.header beginRefreshing];
}

#pragma mark - 数据请求下来之后，停止上下拉刷新，刷新表等
- (void)updateDatasource:(NSArray *)data {
    
    if (_currentPage == 1) {
        [self.tableView.header endRefreshing];
    }
    
    if (data.count > 0) {
        [self.tableView.footer endRefreshing];
        
        if (_currentPage == 1) {
            self.dataSource = [NSMutableArray arrayWithArray:data];
        } else {
            [self.dataSource addObjectsFromArray:data];
        }
        
        
    } else {
        [self.tableView.footer noticeNoMoreData];
    }
    [self.tableView reloadData];
    _currentPage ++;
}

- (UIView *)getHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    return headerView;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.dataSource.count == 0) {
        self.noDataView = [NodataShowView showInContentView:self.tableView withReloadBlock:^{
            [self.tableView.header beginRefreshing];
        } requestResultType:NoserviceType];
        self.noDataView.backgroundColor = background_Color;
    }
    else
    {
        [self.noDataView hide];
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PackageManagerCellIdentifier = @"PackageManagerCellIdentifier2";
    
    XKJHPackageManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:PackageManagerCellIdentifier];
    if (cell == nil) {
        cell = [[XKJHPackageManagerCell alloc] initWithStyle:UITableViewCellStyleDefault type:0 reuseIdentifier:PackageManagerCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    [self loadCellContent:cell indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKJHServiceDetailController *serviceDetailController = [[XKJHServiceDetailController alloc] init];
    
    NSDictionary *contentDic = self.dataSource[indexPath.row];
    serviceDetailController.goodsId = [NSNumber numberWithInteger:[contentDic[@"id"] integerValue]];

    [self.mainNavController pushViewController:serviceDetailController animated:YES];
}

#pragma mark - alert delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {//确定
        [self _requestAddShelfWithGoodsId:[NSNumber numberWithInteger:[self.goodsId integerValue]]];
    }
}

#pragma mark - 接口请求

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    //这里把数据设置给Cell
    XKJHPackageManagerCell *basicCell = (XKJHPackageManagerCell *)cell;
    NSDictionary *contentDic = self.dataSource[indexPath.row];
    basicCell.title.text = [NSString stringWithFormat:@"%@",contentDic[@"ggName"]];
    [basicCell.thumbnail sd_setImageWithURL:[NSURL URLWithString:contentDic[@"groupAccPath"]] placeholderImage:IMAGE(@"logo")];
    basicCell.price.text = [NSString stringWithFormat:@"￥%.2f",[contentDic[@"groupPrice"] doubleValue]];
    basicCell.saledNumber.text = [NSString stringWithFormat:@"已售 %@",[contentDic objectForKey:@"selledCount"]];
    
    WEAK_SELF
    basicCell.pressBlock = ^{
        
        UIAlertView *logOutAlert = [[UIAlertView alloc] initWithTitle:@"确定上架服务？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [logOutAlert show];
        [weak_self.view addSubview:logOutAlert];
        
        weak_self.goodsId = contentDic[@"id"];
        weak_self.currentIndexPath = indexPath;
    };
}

-(void)_requestTableData{
    
    GroupQueryGoodsListRequest *request = [[GroupQueryGoodsListRequest alloc] init:GetToken];
    request.api_ggStatus = [NSNumber numberWithInt:1];
    request.api_goodsType = [NSNumber numberWithInteger:self.requestType];
    request.api_pageNum = [NSNumber numberWithInteger:_currentPage];
    request.api_pageSize = kPageSize;
    
    [self.vapManager groupQueryGoodsList:(request) success:^(AFHTTPRequestOperation *operation, GroupQueryGoodsListResponse *response) {
        
        NSLog(@"%@",response.groupGoodsBOs);
        [self updateDatasource:response.groupGoodsBOs];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

#pragma mark - 上架接口
-(void)_requestAddShelfWithGoodsId:(NSNumber *)goodsId{
    
    GroupGoodsShelvesRequest *request = [[GroupGoodsShelvesRequest alloc] init:GetToken];
    request.api_goodsId = goodsId;
    request.api_goodsStatus = [NSNumber numberWithInt:0];
    
    WEAK_SELF
    [self.vapManager groupGoodsShelves:request success:^(AFHTTPRequestOperation *operation, GroupGoodsShelvesResponse *response) {
        if (![NSString isBlankString:response.subCode]) {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hub.labelText = response.subMsg;
            [hub hide:YES afterDelay:1.5];
        } else {
            [weak_self.dataSource removeObjectAtIndex:weak_self.currentIndexPath.row];
            [weak_self.tableView deleteRowsAtIndexPaths:@[weak_self.currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOffShelfChanged object:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.labelText = @"上架失败";
        [hub hide:YES afterDelay:1.5];
    }];
}

@end
