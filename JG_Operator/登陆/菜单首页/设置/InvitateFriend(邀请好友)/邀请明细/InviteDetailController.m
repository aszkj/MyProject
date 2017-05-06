//
//  InviteDetailController.m
//  jingGang
//
//  Created by HanZhongchou on 15/12/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "InviteDetailController.h"
#import "InviteDetailCell.h"
#import "InviteDetailModel.h"
#import "MJRefresh.h"
#import "NSString+BlankString.h"
//#import "ConfigureDataSource.h"
@interface InviteDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

/**
 *  数据源数组
 */
@property (nonatomic,strong) NSMutableArray *arrayData;
/**
 *  加载页数
 */
@property (nonatomic,assign) NSInteger pageNum;

/**
 *  总推荐人数
 */
@property (nonatomic,copy)   NSString *strRelationCount;
/**
 *  总邀请人数只请求一次，刷新与加载不会刷新
 */
@property (nonatomic,assign) BOOL isFirstRequesCount;

//@property (nonatomic,strong) ConfigureDataSource *configureDataSource;

@end

@implementation InviteDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark --- getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 75.0;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.showsVerticalScrollIndicator = NO;
        
        //添加上拉加载下拉刷新
        WEAK_SELF
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.pageNum = 1;
            [weak_self netWorkRequstWithPageNum:[NSNumber numberWithInteger:weak_self.pageNum] isNeedRemoveObj:YES];
        }];
        _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            weak_self.pageNum++;
            [weak_self netWorkRequstWithPageNum:[NSNumber numberWithInteger:weak_self.pageNum] isNeedRemoveObj:NO];
        }];

        
        //不响应点击cell事件
        _tableView.allowsSelection = NO;
    }
    
    return _tableView;
}

- (NSMutableArray *)arrayData
{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    
    return _arrayData;
}


#pragma mark --- private
//加载UI
- (void)loadUI
{
//    self.navigationItem.title = @"邀请明细";
    
    [self.view addSubview:self.tableView];

    
    self.navigationController.navigationBar.hidden = YES;
 
    //开始网络请求
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.pageNum = 1;
    [self netWorkRequstWithPageNum:[NSNumber numberWithInteger:self.pageNum] isNeedRemoveObj:YES];
    
    
    
    
    //加个View做navBar
    UIView *navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    navBarView.backgroundColor = kGetColor(83, 195, 242);
    [self.view addSubview:navBarView];
    self.tableView.y = CGRectGetMaxY(navBarView.frame) - 20;
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(20, 30, 50, 33);
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [navBarView addSubview:backButton];
    
    //navBar标题label
    UILabel *navBarTitleLabale = [[UILabel alloc]initWithFrame:CGRectMake(0, 27, kScreenWidth, 30)];
    navBarTitleLabale.textColor = [UIColor whiteColor];
    navBarTitleLabale.text = @"邀请明细";
    navBarTitleLabale.textAlignment = NSTextAlignmentCenter;
    [navBarView addSubview:navBarTitleLabale];
    
}


- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//网络请求
- (void)netWorkRequstWithPageNum:(NSNumber *)pageNum isNeedRemoveObj:(BOOL)isNeedRemoveObj
{
    WEAK_SELF
    
    UsersRelationListRequest *request = [[UsersRelationListRequest alloc]init:GetToken];
    request.api_pageNum = pageNum;
    request.api_pageSize = @10;

    VApiManager *vApiManager = [[VApiManager alloc]init];
    
    [vApiManager usersRelationList:request success:^(AFHTTPRequestOperation *operation, UsersRelationListResponse *response) {
        
        //下拉才刷新总人数，上拉加载不刷新总人数
        if (isNeedRemoveObj) {
            if (response.relationCount) {
                weak_self.strRelationCount = [NSString stringWithFormat:@"%@",response.relationCount];
                weak_self.isFirstRequesCount = NO;
            }else{
                weak_self.strRelationCount = @"0";
            }
        }
        
        //处理邀请人的列表数据
        [weak_self loadNetWorkDataWith:response.ralationList isNeedRemoveObj:isNeedRemoveObj];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        [weak_self.tableView.header endRefreshing];
        [weak_self.tableView.footer endRefreshing];
        [weak_self hideHubWithOnlyText:@"网络错误，请检查网络"];
    }];
    
}
//处理邀请人的列表数据
- (void)loadNetWorkDataWith:(NSArray *)array isNeedRemoveObj:(BOOL)isNeedRemoveObj
{
    if (isNeedRemoveObj) {
        [self.arrayData removeAllObjects];
    }
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:array[i]];
        
        [self.arrayData addObject:[InviteDetailModel objectWithKeyValues:dic]];
    }
    
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}


#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"customCellIdentifier";
    
    InviteDetailCell *cell = (InviteDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InviteDetailCell" owner:self options:nil];
        cell = [nib lastObject];
    }
    
    InviteDetailModel *model = self.arrayData[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

#pragma mark -- Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

//顶部view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    viewHeader.backgroundColor = kGetColor(83, 195, 242);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15.0];

    self.strRelationCount = [NSString stringDiseposeNullWithStr:self.strRelationCount];
    
    label.text = [NSString stringWithFormat:@"我的邀请人数：%@",self.strRelationCount];
    [viewHeader addSubview:label];
    
    return viewHeader;
}



@end
