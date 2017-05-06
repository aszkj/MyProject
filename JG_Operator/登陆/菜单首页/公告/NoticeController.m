//
//  NoticeController.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/27.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "NoticeController.h"
#import "NoticeModel.h"
#import "NoticeCell.h"
#import "MerchantPosterDetailVC.h"
#import "NoticeDetailController.h"


@interface NoticeController ()<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL _isAutoFresh;
    NSInteger _requestPageNumber;

}

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic)VApiManager *vapManager;



/**
 *   数据源 --
 */
@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation NoticeController
#pragma mark --- 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 83;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorInset = UIEdgeInsetsMake(5, 0, 0, 0);
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化页面
    [self setupContent];
//    self.view.x
}

/**
 *  初始化页面、数据--
 */
- (void)setupContent {
    self.title = @"公告";
    self.tableView.x = 0;
    self.tableView.y = 0;
    self.tableView.width = kScreenWidth;
    self.tableView.height = kScreenHeight - kNavBarAndStatusBarHeight;
    WEAK_SELF
    //上下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新
        if (!_isAutoFresh) {//如果不是自动刷新
            _requestPageNumber = 1;
            //重置nomoredata
            [weak_self.tableView.footer resetNoMoreData];
            [weak_self _requestPostData];
        }
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //上拉刷新
        [weak_self _requestPostData];
    }];

    _requestPageNumber = 1;
    _isAutoFresh = YES;
    [self.tableView.header beginRefreshing];
    [self _requestPostData];
}

#pragma mark - 请求数据
-(void)_requestPostData {

    _vapManager = [[VApiManager alloc] init];
    UsersOperatorNoticesRequest *request = [[UsersOperatorNoticesRequest alloc] init:GetToken];
    request.api_pageNum = @(_requestPageNumber);
    request.api_pageSize = @5;
    
    [_vapManager usersOperatorNotices:request success:^(AFHTTPRequestOperation *operation, UsersOperatorNoticesResponse *response) {
        
        [self _dealTableFreshUI];
        
        [self _dealWithTableFreshData:response.articleList];
        
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}

#pragma mark - 处理表刷新UI
-(void)_dealTableFreshUI{
    if (_requestPageNumber == 1) {//下拉或自动刷新
        if (_isAutoFresh) {
            _isAutoFresh = NO;
        }
        [_tableView.header endRefreshing];
    }else{
        [_tableView.footer endRefreshing];
    }
}


#pragma mark - 处理表刷新数据
-(void)_dealWithTableFreshData:(NSArray *)array {
    
    NSArray *arr = [ArticleBO JGObjectArrWihtKeyValuesArr:array];
    if (arr.count) {
        if (_requestPageNumber == 1) {//下拉或自动刷新
            self.dataArray = [NSMutableArray arrayWithArray:arr]
            ;
        }else{//上拉刷新
            [self.dataArray addObjectsFromArray:arr];
        }
        _requestPageNumber += 1;
        [_tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
    }else {
        if (_requestPageNumber > 1) {//上拉刷新没数据
            [_tableView.footer noticeNoMoreData];
        }
    }
}

#pragma mark  --- TableViewDelegate --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    headView.backgroundColor = VCBackgroundColor;
    return headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"NoticeCell";
    NoticeCell *cell   = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }

    cell.articleBO = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ArticleBO *model = self.dataArray[indexPath.row];
    MerchantPosterDetailVC *noticeDetailController = [[MerchantPosterDetailVC alloc] init];
    noticeDetailController.title = @"公告详情";
    noticeDetailController.posterID = model.apiId;
    [self.navigationController pushViewController:noticeDetailController animated:YES];
    
}

@end
