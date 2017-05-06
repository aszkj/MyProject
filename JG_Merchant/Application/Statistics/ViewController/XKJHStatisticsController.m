//
//  XKJHStatisticsController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHStatisticsController.h"
#import "XKJHStatisticsHeader.h"
#import "XKJHStatisticsCell.h"
#import "NSString+BlankString.h"

@interface XKJHStatisticsController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *pageData;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, strong) XKJHStatisticsHeader *headerView;
@property (nonatomic, strong) NSString *totalBill;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation XKJHStatisticsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight - kNavBarAndStatusBarHeight);
    _totalBill = @"0";
    
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.delaysContentTouches = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    _tableView.contentOffset = CGPointMake(0, 0);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
//    self.pageData = [[NSMutableArray alloc] initWithObjects:@"问题反馈",@"帮助",@"关于云医生",@"联系客服",@"版本号", nil];
    
    if (_statisticsType == StatisticsConsume) {
        [self _requestRebateCountDataWithStartTime];
    } else if (_statisticsType == StatisticsOnLine){
        [self _requestOnlineOrderCountListData];
    } else if (_statisticsType == StatisticsOffLine){
        [self _requestOfflineOrderCountListData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (XKJHStatisticsHeader *)headerView {
    
    if (!_headerView) {
        _headerView = [[XKJHStatisticsHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, 308)];
        
        [_headerView.startTimeBtn setTitle:[NSString stringWithFormat:@"%ld-01-01",(long)self.currentYear] forState:UIControlStateNormal];
        [_headerView.endTimeBtn setTitle:[NSString stringWithFormat:@"%ld-12-31",(long)self.currentYear] forState:UIControlStateNormal];
        if (![NSString isBlankString:self.totalBill]) {
            _headerView.totalBillText.text = self.totalBill;
        }
        
        __unsafe_unretained XKJHStatisticsController *weak_self = self;
        _headerView.btnPressBlock = ^ (NSString *startTime,NSString *endTime){
            
            if (_statisticsType == StatisticsConsume) {
                [weak_self _requestConsumShareListDataWithStartTime:startTime endTime:endTime];
                
            } else if (_statisticsType == StatisticsOnLine){
                
                [weak_self _requestOnlineOrderStatisticsDataWithStartTime:startTime endTime:endTime];
            } else if (_statisticsType == StatisticsOffLine){
                
                [weak_self _requestOfflineOrderStatisticsDataWithStartTime:startTime endTime:endTime];
            }
        };
    }
    return _headerView;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView.totalBillText.text = self.totalBill;

    return self.headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.pageData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 308;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *StatisticsCellIdentifier = @"StatisticsCellIdentifier";
    XKJHStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:StatisticsCellIdentifier];
    if (cell == nil) {
        cell = [[XKJHStatisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StatisticsCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [self loadCellContent:cell indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark- private methord

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    //这里把数据设置给Cell
    XKJHStatisticsCell *basicCell = (XKJHStatisticsCell *)cell;
    NSDictionary *contentDic = self.pageData[indexPath.row];
    basicCell.time.text = [NSString stringWithFormat:@"%@年%@月份",contentDic[@"years"],contentDic[@"months"]];
    
    if (self.statisticsType == StatisticsConsume) {
        
        basicCell.income.text = [NSString stringWithFormat:@"%.2f",[[contentDic objectForKey:@"totalRebateAmout"] doubleValue]];
    } else {
        
        basicCell.income.text = [NSString stringWithFormat:@"%.2f",[[contentDic objectForKey:@"monthTotalPrice"] floatValue]];
    }
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    return _dateFormatter;
}

- (MBProgressHUD *)hud {
    
    if(!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_hud];
        _hud.labelText = @"请稍后...";
        _hud.removeFromSuperViewOnHide = YES;
    }
    return _hud;
}

- (NSInteger)currentYear{
    if (!_currentYear || _currentYear <= 0) {
        NSDate *now = [NSDate date];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        _currentYear = [dateComponent year];
    }
    
    return _currentYear;
}

#pragma mark - 接口请求

#pragma mark - 消费分润收入统计
-(void)_requestConsumShareListDataWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    [self.hud show:YES];
    
    GroupConsumShareListRequest *request = [[GroupConsumShareListRequest alloc] init:GetToken];
    
//    request.api_orderType = [NSNumber numberWithInteger:_statisticsType];
    request.api_startTime = startTime;
    request.api_endTime = endTime;
    
    WEAK_SELF
    [self.vapManager groupConsumShareList:(request) success:^(AFHTTPRequestOperation *operation, GroupConsumShareListResponse *response) {

        [weak_self.hud hide:YES];
        weak_self.hud = nil;
        
        if (response.rebateBO) {
            NSDictionary *dic = (NSDictionary *)response.rebateBO;
            weak_self.totalBill = [NSString stringWithFormat:@"%.2f",[dic[@"totalRebateAmout"] doubleValue]];
            
        } else {
            weak_self.totalBill = @"0";
        }
        [weak_self.tableView reloadData];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [weak_self.hud hide:YES];
        weak_self.hud = nil;
    }];
}

#pragma mark - 线上服务收入统计
-(void)_requestOnlineOrderStatisticsDataWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    [self.hud show:YES];

    GroupOrderLineStatisticsRequest *request = [[GroupOrderLineStatisticsRequest alloc] init:GetToken];
    request.api_orderType = [NSNumber numberWithInteger:_statisticsType];
    request.api_startTime = startTime;
    request.api_endTime = endTime;
    
    WEAK_SELF
    [self.vapManager groupOrderLineStatistics:request success:^(AFHTTPRequestOperation *operation, GroupOrderLineStatisticsResponse *response) {
        
        [weak_self.hud hide:YES];
        weak_self.hud = nil;
        
        if (response.totalPrice) {
            weak_self.totalBill = [NSString stringWithFormat:@"%.2f",[response.totalPrice doubleValue]];
        } else {
            weak_self.totalBill = @"0";
        }
        
        [weak_self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self.hud hide:YES];
        weak_self.hud = nil;
    }];
}


#pragma mark - 线下服务收入统计
-(void)_requestOfflineOrderStatisticsDataWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    [self.hud show:YES];
    
    GroupOrderStatisticsRequest *request = [[GroupOrderStatisticsRequest alloc] init:GetToken];
    request.api_orderType = [NSNumber numberWithInteger:_statisticsType];
    request.api_startTime = startTime;
    request.api_endTime = endTime;
    
    WEAK_SELF
    [self.vapManager groupOrderStatistics:request success:^(AFHTTPRequestOperation *operation, GroupOrderStatisticsResponse *response) {
        
        [weak_self.hud hide:YES];
        weak_self.hud = nil;
        
        if (response.totalPrice) {
            weak_self.totalBill = [NSString stringWithFormat:@"%.2f",[response.totalPrice doubleValue]];
        } else {
            weak_self.totalBill = @"0";
        }
        
        [weak_self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self.hud hide:YES];
        weak_self.hud = nil;

    }];
}

#pragma mark - 收入统计

#pragma mark - 消费分润当前年的月统计
-(void)_requestRebateCountDataWithStartTime{
    
    [self.hud show:YES];
    
    GroupRebateCountRequest *request = [[GroupRebateCountRequest alloc] init:GetToken];
    
    WEAK_SELF
    [self.vapManager groupRebateCount:request success:^(AFHTTPRequestOperation *operation, GroupRebateCountResponse *response) {
        
        weak_self.pageData = response.rebateList;
        
        NSString *startTime = [NSString stringWithFormat:@"%ld-01-01",(long)weak_self.currentYear];
        NSString *endTime = [NSString stringWithFormat:@"%ld-12-31",(long)weak_self.currentYear];
        
        [weak_self _requestConsumShareListDataWithStartTime:startTime endTime:endTime];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        [weak_self.hud hide:YES];
        weak_self.hud = nil;
    }];
}

#pragma mark - 当年线上服务收入月统计
-(void)_requestOnlineOrderCountListData{
    
    [self.hud show:YES];
    
    GroupOrderMonthListRequest *request = [[GroupOrderMonthListRequest alloc] init:GetToken];
    
    WEAK_SELF
    
    [self.vapManager groupOrderMonthList:request success:^(AFHTTPRequestOperation *operation, GroupOrderMonthListResponse *response) {
        
        weak_self.pageData = response.orderTotalPriceList;
        
        NSString *startTime = [NSString stringWithFormat:@"%ld-01-01",(long)weak_self.currentYear];
        NSString *endTime = [NSString stringWithFormat:@"%ld-12-31",(long)weak_self.currentYear];
//        NSString *endTime = [weak_self.dateFormatter stringFromDate:[NSDate date]];
        
        [weak_self _requestOnlineOrderStatisticsDataWithStartTime:startTime endTime:endTime];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self.hud hide:YES];
        weak_self.hud = nil;

    }];
}

#pragma mark - 当年线下服务收入月统计
-(void)_requestOfflineOrderCountListData{
    
    [self.hud show:YES];
    
    GroupOrderCountListRequest *request = [[GroupOrderCountListRequest alloc] init:GetToken];
    request.api_orderType = [NSNumber numberWithInteger:_statisticsType];
    
    WEAK_SELF
    [self.vapManager groupOrderCountList:request success:^(AFHTTPRequestOperation *operation, GroupOrderCountListResponse *response) {
        
        weak_self.pageData = response.orderTotalPriceList;
        
        NSString *startTime = [NSString stringWithFormat:@"%ld-01-01",(long)weak_self.currentYear];
        NSString *endTime = [weak_self.dateFormatter stringFromDate:[NSDate date]];
        [self _requestOfflineOrderStatisticsDataWithStartTime:startTime endTime:endTime];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self.hud hide:YES];
        weak_self.hud = nil;
    }];
}

@end
