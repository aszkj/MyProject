//
//  NoticeController.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/27.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "NoticeController.h"
#import "NoticeCell.h"
#import "MerchantPosterDetailVC.h"
#import "GlobeObject.h"
#import "PublicInfo.h"
#import "MJRefresh.h"
#import "NSObject+MJExtension.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"

@interface NoticeController ()<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL _isAutoFresh;
    NSInteger _requestPageNumber;

}

@property (assign,nonatomic) BOOL isAutoFresh;
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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [Util setNavTitleWithTitle:@"公告" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    self.tableView.x = 0;
    self.tableView.y = 0;
    self.tableView.width = kScreenWidth;
    self.tableView.height = kScreenHeight - kStatuBarAndNavBarHeight;
    WEAK_SELF
    //上下拉刷新

    [self.tableView addHeaderWithCallback:^{
        //下拉刷新
        if (!weak_self.isAutoFresh) {//如果不是自动刷新
            _requestPageNumber = 1;
            //重置nomoredata
            [weak_self _requestPostData];
        }
    }];
    
    
//    [self.tableView addFooterWithCallback:^{
//        [weak_self _requestPostData];
//    }];

    _requestPageNumber = 1;
    _isAutoFresh = YES;
    [self.tableView headerBeginRefreshing];
    [self _requestPostData];
}

#pragma mark - 请求数据
-(void)_requestPostData {

    _vapManager = [[VApiManager alloc] init];
   
    
    UsersArticMarkListRequest *request = [[UsersArticMarkListRequest alloc] init:GetToken];
    request.api_mark = @"gonggao";
    request.api_pageNum = @(_requestPageNumber);
    request.api_pageNum = @(1);
    request.api_pageSize = @200;
    
    [_vapManager usersArticMarkList:request success:^(AFHTTPRequestOperation *operation, UsersArticMarkListResponse *response) {
        
        NSLog(@"公告response %@",response);
        
        [self _dealTableFreshUI];
        
        [self _dealWithTableFreshData:response.articMarkleList];
        


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
//    [_vapManager usersOperatorNotices:request success:^(AFHTTPRequestOperation *operation, UsersOperatorNoticesResponse *response) {
//        
//        [self _dealTableFreshUI];
//        
//        [self _dealWithTableFreshData:response.articleList];
//        
//      
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//    }];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 处理表刷新UI
-(void)_dealTableFreshUI{
    if (_requestPageNumber == 1) {//下拉或自动刷新
        if (_isAutoFresh) {
            _isAutoFresh = NO;
        }
        [_tableView headerEndRefreshing];
    }else{
        [_tableView footerEndRefreshing];
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
    noticeDetailController.posterID = model.apiId;
    [self.navigationController pushViewController:noticeDetailController animated:YES];
    
}

@end
