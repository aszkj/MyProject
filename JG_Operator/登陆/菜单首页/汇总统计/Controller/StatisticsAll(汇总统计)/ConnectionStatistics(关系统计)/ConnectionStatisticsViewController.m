//
//  ConnectionStatisticsViewController.m
//  Operator_JingGang
//
//  Created by HanZhongchou on 15/10/30.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ConnectionStatisticsViewController.h"
#import "ConnectionStatisticsCell.h"
@interface ConnectionStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayCount; //数据源数组
@property (nonatomic,strong) NSArray *arrayCellTitle;//每项关系的标题
//@property (nonatomic,strong) NSDictionary *dicConnectionStatisticsInfo;//解析出来的字典
@end

@implementation ConnectionStatisticsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    //网络请求
    [self netWorkRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//
#pragma mark - private
/**
 *  网络请求
 */
- (void)netWorkRequest
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WEAK_SELF
    VApiManager *netManaget = [[VApiManager alloc]init];
    OperatorStatisRelationListRequest *request = [[OperatorStatisRelationListRequest alloc]init:GetToken];
    [netManaget operatorStatisRelationList:request success:^(AFHTTPRequestOperation *operation, OperatorStatisRelationListResponse *response) {
        //网络传来的模型转成字典
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[response.operatorRelation keyValues]];
        [weak_self loadNetWorkData:dic];
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    }];

}
/**
 *  处理网络请求回来的数据
 *
 *  @param dic 网络解析出来的字典
 */
- (void)loadNetWorkData:(NSDictionary *)dic{
    
    [self.arrayCount removeAllObjects];
    
    NSString *strOperatorRegisterCount = [NSString stringWithFormat:@"%@",dic[@"operatorRegisterCount"]];
    NSString *strStoreRegisterCount    = [NSString stringWithFormat:@"%@",dic[@"storeRegisterCount"]];
    NSString *strUserRegisterCount     = [NSString stringWithFormat:@"%@",dic[@"userRegisterCount"]];
    NSString *strAreaOperatorCount     = [NSString stringWithFormat:@"%@",dic[@"areaOperatorCount"]];
    NSString *strMembershipCount       = [NSString stringWithFormat:@"%@",dic[@"membershipCount"]];
    NSString *strMembershipUserCount   = [NSString stringWithFormat:@"%@",dic[@"membershipUserCount"]];
    
    
    self.arrayCount = [NSMutableArray arrayWithObjects:strOperatorRegisterCount,strStoreRegisterCount,strUserRegisterCount,strAreaOperatorCount,strMembershipCount,strMembershipUserCount, nil];
    
    [self.tableView reloadData];
}

//tableview的线补齐
- (void)tableViewLineRepair:(UITableView *)tableView{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Delegate
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayCellTitle.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifia = @"ConnectionCell";
    
    ConnectionStatisticsCell *cell = (ConnectionStatisticsCell *)[tableView dequeueReusableCellWithIdentifier:identifia];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ConnectionStatisticsCell" owner:self options:nil];
        cell = [nib lastObject];
    }
    cell.labelConnection.text = [NSString stringWithFormat:@"%@%@个",self.arrayCellTitle[indexPath.row],self.arrayCount[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}



//
//#pragma mark - action
//
#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 4, kScreenWidth, kScreenHeight - 97) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = rgb(234, 235, 236, 1);
        _tableView.rowHeight = 42;
        [self tableViewLineRepair:_tableView];
    }
    return _tableView;
}

/**
 *  初始化数据源数组
 */
//- (NSMutableArray *)arrayCount
//{
//    if (!_arrayCount) {
//        _arrayCount = [NSMutableArray array];
//    }
//    return _arrayCount;
//}
/**
 *  初始化每项关系标题
 */
- (NSArray *)arrayCellTitle
{
    if (!_arrayCellTitle) {
        _arrayCellTitle = [NSArray arrayWithObjects:@"注册运营商：",@"注册的商户：",@"注册的会员：",@"辖区运营商：",@"隶属的商户：",@"隶属商户的会员：", nil];
 }
    return _arrayCellTitle;
}


@end
