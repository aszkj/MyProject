//
//  TestHistoryVC.m
//  jingGang
//
//  Created by wangying on 15/6/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "TestHistoryVC.h"
#import "PublicInfo.h"
#import "TestCell.h"
#import "VApiManager.h"
#import "userDefaultManager.h"
#import "SelftestDetailVC.h"
#import "SelfTestResultVC.h"
#import "GlobeObject.h"
#import "MJRefresh.h"
#define PageSize 5

@interface TestHistoryVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
   
    VApiManager * _VApManager;
    NSMutableArray *arr_data;
    
    UIImageView *img;
    UIView *view;
    
    NSInteger _currentPage;
    
    BOOL      _isHeaderAutoFresh;
}


@property (nonatomic,assign)BOOL isHeaderAutoFresh;

@end

@implementation TestHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];

    arr_data = [[NSMutableArray alloc]init];
    
//    [self dosomeRequest];
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(BtnClick_bg) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
      UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
      UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    l.text = @"自测历史";
    l.textColor = [UIColor whiteColor];
    l.font = [UIFont systemFontOfSize:18];
    l.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = l;
    RELEASE(l);
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
   
        
        CGFloat width = __MainScreen_Width/2-60;
        CGFloat height = __MainScreen_Height/2 - 50;
        view =[[UIView alloc]initWithFrame:CGRectMake(width, height, 120, 100)];
       
        UILabel *l_ss = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, view.frame.size.width, 30)];

        l_ss.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [view addSubview:l_ss];
       
        img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blank_test"]];
        l_ss.text = @"您还没有做过测试";
        l_ss.font = [UIFont systemFontOfSize:15];
        img.frame = CGRectMake(width/2-60/2, 0, 60, 60);
    
        RELEASE( l_ss);
    
    [self creatTableView];
    
    
}


-(void)dosomeRequest
{
    _VApManager = [[VApiManager alloc] init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersCheckHistoryRequest *usersCheckHistoryRequest = [[UsersCheckHistoryRequest alloc] init:accessToken];
    
    usersCheckHistoryRequest.api_pageNum = @(_currentPage);
    usersCheckHistoryRequest.api_pageSize = @(PageSize);

    [_VApManager usersCheckHistory:usersCheckHistoryRequest success:^(AFHTTPRequestOperation *operation, UsersCheckHistoryResponse *response) {
        
        if (_currentPage == 1 && !_isHeaderAutoFresh) {//下拉刷新
            [_tableView headerEndRefreshing];
        }else{//上拉
            [_tableView footerEndRefreshing];
        }
        
        if (_isHeaderAutoFresh) {
            [_tableView headerEndRefreshing];
            _isHeaderAutoFresh = NO;
        }
        
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"自测历史%@",response);
        NSArray *arrt = [dict objectForKey:@"checkResults"];
        if(arrt.count == 0 && _currentPage == 1){
            [self.view addSubview:view];
            [view addSubview:img];
        }
        
        NSMutableArray *requestDataArr = [NSMutableArray arrayWithCapacity:0];
        for (int i =0; i<arrt.count; i++) {
            [requestDataArr addObject:arrt[i]];
        }
        if (_currentPage == 1) {//下拉刷新，替换数据源
            arr_data = requestDataArr;
        }else{//上拉，加在后面
            [arr_data addObjectsFromArray:requestDataArr];
        }
        
        NSLog(@"sss %@",arr_data);
        
        [_tableView reloadData];
        
        _currentPage ++;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"查询自测历史失败");
        
    }];

}


-(void)BtnClick_bg
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, __MainScreen_Width, __MainScreen_Height-64-5)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    WEAK_SELF
    [_tableView addHeaderWithCallback:^{
        //下拉刷新
        _currentPage = 1;
        if (!weak_self.isHeaderAutoFresh) {//如果不是开始头部自动刷新
            
            [weak_self dosomeRequest];
        }
    }];

    [_tableView addFooterWithCallback:^{
        
        [weak_self dosomeRequest];
    }];
    _currentPage = 1;
    _isHeaderAutoFresh = YES;
    [_tableView headerBeginRefreshing];
    [self dosomeRequest];
    
    //预估算行高
//    _tableView.estimatedRowHeight = 128;
//    _tableView.rowHeight = UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = 0;
    height = kStringSize([[arr_data objectAtIndex:indexPath.row] objectForKey:@"desc"], 16.0, __MainScreen_Width-26, MAXFLOAT).height+120+7;
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        NSArray *arr =[[NSBundle mainBundle] loadNibNamed:@"TestCell" owner:self options:nil];
        cell = [arr objectAtIndex:0];
    }
    if (arr_data.count >0) {
        //cell.lint_l =
       // cell.total_v
        NSDictionary *sd = arr_data[indexPath.row];
        cell.time_t.text = [NSString stringWithFormat:@"%@",[sd objectForKey:@"createTime"]];
        cell.zhengz_l.text = [sd objectForKey:@"groupTitle"];
        cell.text_l.text = [sd objectForKey:@"desc"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor =[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

//    NSDictionary *dic = arr_data[indexPath.row];
//    
//    SelfTestResultVC *selfT =[[SelfTestResultVC alloc]init];
//    selfT.comminFromHistory = YES;
//    selfT.testResultDec =  [dic objectForKey:@"resultDesc"];
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
////    NSDictionary *dic = arr_data[indexPath.row];
////    
////    
////    
////    
////    SelfTestResultVC *selfT =[[SelfTestResultVC alloc]init];
////    selfT.comminFromHistory = YES;
////    selfT.testResultDec =  [dic objectForKey:@"resultDesc"];
////    
////      [tableView deselectRowAtIndexPath:indexPath animated:YES];
////
//    [self.navigationController pushViewController:selfT animated:YES];

    RELEASE(selfT);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
