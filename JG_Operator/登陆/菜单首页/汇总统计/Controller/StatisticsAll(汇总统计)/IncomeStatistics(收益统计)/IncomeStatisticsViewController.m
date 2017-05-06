//
//  IncomeStatisticsViewController.m
//  Operator_JingGang
//
//  Created by HanZhongchou on 15/10/30.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "IncomeStatisticsViewController.h"
#import "IncomeStatisticstaTableHeadView.h"
#import "MerchantManageCell.h"
#import "MJExtension.h"
#import "IncomeStatisticsModel.h"
#import "IncomeProfitCell.h"
@interface IncomeStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource,IncomeStatisticstaTableHeadViewDelegate>
@property (nonatomic,strong) UITableView *tableViewMain;
@property (nonatomic,strong) IncomeStatisticstaTableHeadView *tableHeadView;//tableViewHeadView
@property (nonatomic,strong) NSArray *arrayCellTitle;                       //cell的项目label数组
@property (nonatomic,strong) UITableView *tabelViewSelectTime;              //弹出的周，月，季度，年选择框
@property (nonatomic,strong) NSArray *arraySelectTime;                      //操作时段数组
@property (nonatomic,strong) UIView  *viewSelectTimeTableViewBg;            //操作时段tableview背景view
@property (nonatomic,strong) NSDictionary *dicIncomeStatisticsInfo;         //网络请求返回解析的字典
@property (nonatomic,strong) NSMutableArray *arrayIncomeStatisticsInfo;     //网络请求回来的字典解析出来的数组
@property (nonatomic,strong) UILabel *labelTotal;                            //总云币label

@end

@implementation IncomeStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //默认一进来就先请求本周的收益
    
    //选择时段 0全部,w本周统计,m本月统计,q本季统计,h本半年统计,y本年统计    select为是否选择tableview选择时段
    [self netWorkRequestWithStartTime:nil OverTime:nil SelectTime:@"w" isSelect:YES];
    [self loadUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - private
/**
 *  加载UI
 */
- (void)loadUI
{
    self.view.backgroundColor = VCBackgroundColor;
    [self.view addSubview:self.tableViewMain];
}
//选择时段 0全部,w本周统计,m本月统计,q本季统计,h本半年统计,y本年统计    select为是否选择tableview选择时段
- (void)netWorkRequestWithStartTime:(NSString *)startTime OverTime:(NSString *)overTime SelectTime:(NSString *)selectTime isSelect:(BOOL)isSelect;
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WEAK_SELF
    VApiManager *netManaget = [[VApiManager alloc]init];
    OperatorProfitStatisListRequest *request = [[OperatorProfitStatisListRequest alloc]init:GetToken];
    if (isSelect) {
        request.api_queryType = selectTime;
    }else{
        request.api_startTime = startTime;
        request.api_endTime   = overTime;
        request.api_queryType = @"0";
    }
    request.api_pageNum = [NSNumber numberWithInteger:1];
    request.api_pageSize = [NSNumber numberWithInteger:10];
    [netManaget operatorProfitStatisList:request success:^(AFHTTPRequestOperation *operation, OperatorProfitStatisListResponse *response) {
        weak_self.dicIncomeStatisticsInfo = [response keyValues];
        [weak_self loadNetWorkData:weak_self.dicIncomeStatisticsInfo];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JGLog(@"%@",error);
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    }];
    
}

/**
 *  处理网络传来的数据
 */
- (void)loadNetWorkData:(NSDictionary *)dic
{
    NSArray *array = [NSArray arrayWithArray:dic[@"operatorpProfitList"]];
    

    [self.arrayIncomeStatisticsInfo removeAllObjects];

    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dicDetailsList = [NSDictionary dictionaryWithDictionary:array[i]];
        
        [self.arrayIncomeStatisticsInfo addObject:[IncomeStatisticsModel objectWithKeyValues:dicDetailsList]];
    }
    self.labelTotal.text = [NSString stringWithFormat:@"总计:%@云币",dic[@"profitTotal"]];
    [self.tableViewMain reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_viewSelectTimeTableViewBg) {
        self.viewSelectTimeTableViewBg.hidden = YES;
        self.tabelViewSelectTime.hidden = YES;
    }
}


#pragma mark - Delegate
#pragma mark - UITableViewDelegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tabelViewSelectTime) {
        return self.arraySelectTime.count;
    }else{
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableViewMain) {
        
        //前4行显示的是一种cell
        if (indexPath.row < 4) {
            static NSString *identifer = @"cell";
            MerchantManageCell *cell = (MerchantManageCell *)[tableView dequeueReusableCellWithIdentifier:identifer];
            if(!cell){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MerchantManageCell" owner:self options:nil];
                cell = [nib lastObject];
            }
            cell.strStatus = [NSString stringWithFormat:@"IncomeStatisticsViewController"];
            if (self.arrayIncomeStatisticsInfo.count > 0) {
                IncomeStatisticsModel *model = self.arrayIncomeStatisticsInfo[indexPath.row];
                cell.model = model;
            }
            cell.dicItemName = [NSDictionary dictionaryWithDictionary:self.arrayCellTitle[indexPath.row]];
            
            return cell;
        }else if (indexPath.row > 3 ){
            static NSString *identifer = @"incomeCell";
            IncomeProfitCell *cell = (IncomeProfitCell *)[tableView dequeueReusableCellWithIdentifier:identifer];
            if(!cell){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IncomeProfitCell" owner:self options:nil];
                cell = [nib lastObject];
            }
            if (self.arrayIncomeStatisticsInfo.count >0) {
                IncomeStatisticsModel *model = self.arrayIncomeStatisticsInfo[indexPath.row];
                if (indexPath.row == 4) {
                    cell.labelIncomePrice.text = [NSString stringWithFormat:@"%@",model.rcRebate];
                }else if (indexPath.row == 5){
                    cell.labelIncomePrice.text = [NSString stringWithFormat:@"%@",model.rsRebate];
                }
            }
            
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:self.arrayCellTitle[indexPath.row]];
            cell.labelIncome.text = [NSString stringWithFormat:@"%@",dic[@"incomeTitle"]];
            
            return cell;
            
        }
        
        
        
    }else{
        static NSString * myCell= @"SelectTimeCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
            cell.textLabel.font = kFontSize13;
            cell.textLabel.textColor = KColorText666666;
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.arraySelectTime[indexPath.row]];
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tabelViewSelectTime) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSString *str = [NSString stringWithFormat:@"%@",self.arraySelectTime[indexPath.row]];
        //选择时段 0全部,w本周统计,m本月统计,q本季统计,h本半年统计,y本年统计
        NSArray *arraySelecteTime = [NSArray arrayWithObjects:@"w",@"m",@"q",@"h",@"y",@"0", nil];
        NSString *strSelectTime = [NSString stringWithFormat:@"%@",arraySelecteTime[indexPath.row]];
        [self netWorkRequestWithStartTime:nil OverTime:nil SelectTime:strSelectTime isSelect:YES];
        
        self.tableHeadView.labelSelectLater.text = str;
        self.viewSelectTimeTableViewBg.hidden = YES;
        self.tabelViewSelectTime.hidden = YES;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat rowHeight = 40.0;
    if (tableView == self.tableViewMain) {
        if (indexPath.row < 4) {
            rowHeight = 150.0;
        }else if (indexPath.row > 3){
            rowHeight = 75.0;
        }
    }
    
    return rowHeight;
}

#pragma mark --incomeStatisticcsTableHeadViewDelegate
/**
 *  点击了tableHeadView的选择时段按钮
 */
- (void)NofitiCationSelectButtonClick
{
    if (!_viewSelectTimeTableViewBg) {
        [self.view addSubview:self.viewSelectTimeTableViewBg];
        [self.view addSubview:self.tabelViewSelectTime];
        return;
    }
    if (self.viewSelectTimeTableViewBg.hidden == YES) {
        self.viewSelectTimeTableViewBg.hidden = NO;
        self.tabelViewSelectTime.hidden = NO;
    }else{
        self.viewSelectTimeTableViewBg.hidden = YES;
        self.tabelViewSelectTime.hidden = YES;
    }
}
/**
 *  点击了tableHeadView的选择时段按钮(确定button)
 */
- (void)NofitiCationConfirmButtonClikStartTimeWith:(NSString *)startTime overTime:(NSString *)overTime
{
    [self netWorkRequestWithStartTime:startTime OverTime:overTime SelectTime:nil isSelect:NO];
}

#pragma mark --getter
- (UITableView *)tableViewMain
{
    if (!_tableViewMain) {
        _tableViewMain = [[UITableView alloc]initWithFrame:CGRectMake(0, 4, kScreenWidth, kScreenHeight - 97) style:UITableViewStylePlain];
        _tableViewMain.delegate = self;
        _tableViewMain.dataSource = self;
        _tableViewMain.tableHeaderView = self.tableHeadView;
        _tableViewMain.tableFooterView = [self loadTableFootView];
        _tableViewMain.rowHeight = 150.0;
        _tableViewMain.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _tableViewMain.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableViewMain.showsVerticalScrollIndicator = NO;
        
        _tableViewMain.backgroundColor = [UIColor clearColor];
    }
    return _tableViewMain;
}

/**
 *  初始化选择时段tableview
 */
- (UITableView *)tabelViewSelectTime
{
    if (!_tabelViewSelectTime) {
        _tabelViewSelectTime = [[UITableView alloc]initWithFrame:CGRectMake(8, 50, kScreenWidth - 16, 285) style:UITableViewStylePlain];
        _tabelViewSelectTime.center = self.view.center;
        _tabelViewSelectTime.delegate = self;
        _tabelViewSelectTime.dataSource = self;
        _tabelViewSelectTime.showsVerticalScrollIndicator = NO;
        _tabelViewSelectTime.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tabelViewSelectTime.frame.size.width, 45)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 120, 20)];
        label.text = @"请选择时段";
        CGPoint ponitLabel = label.center;
        ponitLabel.y = view.center.y;
        label.center = ponitLabel;
        [view addSubview:label];
        _tabelViewSelectTime.tableHeaderView = view;
    }
    return _tabelViewSelectTime;
}
/**
 *  初始化MainTableHeadView
 */
- (IncomeStatisticstaTableHeadView *)tableHeadView
{
    if (!_tableHeadView) {
        _tableHeadView = [[IncomeStatisticstaTableHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
        _tableHeadView.backgroundColor = [UIColor whiteColor];
        _tableHeadView.delegate = self;
    }
    return _tableHeadView;
}
/**
 *  初始化cell的label数组
 */
- (NSArray *)arrayCellTitle
{
    if (!_arrayCellTitle) {
        NSDictionary *dicRegister = @{@"incomeTitle":@"注册返润收益",@"oneItem":@"推荐运营商",@"twoItem":@"推荐商户",@"threeItem":@"推荐会员"};
        NSDictionary *dicPopedom  = @{@"incomeTitle":@"辖区返润收益",@"oneItem":@"本辖本消",@"twoItem":@"本辖外消",@"threeItem":@"外辖本消"};
        NSDictionary *dicSubordinate = @{@"incomeTitle":@"隶属返润收益",@"oneItem":@"本隶本消",@"twoItem":@"本隶外消",@"threeItem":@"外隶本消"};
        NSDictionary *dicPay = @{@"incomeTitle":@"支付手续收益",@"oneItem":@"隶属支付",@"twoItem":@"辖区支付",@"threeItem":@"推荐收益"};
        NSDictionary *dicIncomePrice = @{@"incomeTitle":@"推荐商品分润"};
        NSDictionary *dicIncome = @{@"incomeTitle":@"推荐购买分润"};
        _arrayCellTitle = [NSArray arrayWithObjects:dicRegister,dicPopedom,dicSubordinate,dicPay,dicIncomePrice,dicIncome, nil];
    }
    return _arrayCellTitle;
}

/**
 *  初始化时间选择数组
 */
- (NSArray *)arraySelectTime
{
    if (!_arraySelectTime) {
        _arraySelectTime = [NSArray arrayWithObjects:@"本周统计",@"本月统计",@"本季度统计",@"本半年统计",@"本年度统计",@"全部", nil];
    }
    return _arraySelectTime;
}
/**
 *  初始化时间选择tableview背景view
 */
- (UIView *)viewSelectTimeTableViewBg
{
    if (!_viewSelectTimeTableViewBg) {
        _viewSelectTimeTableViewBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _viewSelectTimeTableViewBg.backgroundColor = [UIColor blackColor];
        _viewSelectTimeTableViewBg.alpha = 0.4;
    }
    return _viewSelectTimeTableViewBg;
}
/**
 *  初始化数据字典
 */
- (NSDictionary *)dicIncomeStatisticsInfo
{
    if (!_dicIncomeStatisticsInfo) {
        _dicIncomeStatisticsInfo = [NSDictionary dictionary];
    }
    return _dicIncomeStatisticsInfo;
}
- (NSMutableArray *)arrayIncomeStatisticsInfo
{
    if (!_arrayIncomeStatisticsInfo) {
        _arrayIncomeStatisticsInfo = [NSMutableArray array];
    }
    return _arrayIncomeStatisticsInfo;
}

/**
 *  初始化tableviewfootView
 */

- (UIView *)loadTableFootView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 44)];
    view.backgroundColor = [UIColor whiteColor];
    self.labelTotal = [[UILabel alloc]initWithFrame:CGRectMake(15, 15,kScreenWidth - 30 , 17)];
    self.labelTotal.text = [NSString stringWithFormat:@"总计: 云币"];
    self.labelTotal.font = kFontSize14;
    [view addSubview:self.labelTotal];
    return view;
}

@end
