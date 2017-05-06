//
//  XKJHViolateShelfController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHViolateShelfController.h"
#import "XKJHPackageManagerCell.h"
#import "NodataShowView.h"
#import "XKJHServiceDetailController.h"

@interface XKJHViolateShelfController ()
@property (nonatomic, strong) NodataShowView *noDataView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,strong) VApiManager *vapManager;
@property (assign, nonatomic) NSInteger currentPage;
@property(nonatomic,strong) NSString *goodsId;
//@property(nonatomic,strong) NSIndexPath *currentIndexPath;

@end

@implementation XKJHViolateShelfController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化数据源
    self.dataSource = [[NSMutableArray alloc] init];

    [self _initTable];
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
    [self _autoFresh];
}

- (VApiManager *)vapManager
{
    if (!_vapManager) {
        _vapManager = [[VApiManager alloc] init];
    }
    return _vapManager;
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
    static NSString *PackageManagerCellIdentifier = @"PackageManagerCellIdentifier3";
    
    XKJHPackageManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:PackageManagerCellIdentifier];
    if (cell == nil) {
        cell = [[XKJHPackageManagerCell alloc] initWithStyle:UITableViewCellStyleDefault type:3 reuseIdentifier:PackageManagerCellIdentifier];
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
}

-(void)_requestTableData{
    
    GroupQueryGoodsListRequest *request = [[GroupQueryGoodsListRequest alloc] init:GetToken];
    request.api_ggStatus = [NSNumber numberWithInt:-2];
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

@end
