//
//  MoneyRecordViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "MoneyRecordViewController.h"
#import "CustomBasicTableViewCell.h"
#import "ConsumptionSubRunViewController.h"
#import "IncomeOnlineViewController.h"
#import "IncomeCardViewController.h"

@interface MoneyRecordViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *dataSource;
@end

@implementation MoneyRecordViewController
static NSString *cellIdentifier = @"CustomBasicTableViewCell";

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self setUIContent];
    [self setViewsMASConstraint];
    [self RACProgress];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animate {
    [super viewWillDisappear:animate];
    
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)getHeightTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    return 49.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showMoneyListWithIndex:indexPath.section];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
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
    CustomBasicTableViewCell *basicCell = (CustomBasicTableViewCell *)cell;
    NSArray *contentArray = self.dataSource[indexPath.section];
    basicCell.leftImageView.image = [UIImage imageNamed:contentArray[0]];
    basicCell.basicTitle.text = contentArray[1];
}


#pragma mark - CustomDelegate



#pragma mark - event response

- (void)showMoneyListWithIndex:(NSInteger)index {
    UIViewController *VC;
    if (index == 0) {
        VC = [[ConsumptionSubRunViewController alloc] init];
    } else if (index == 1) {
        VC = [[IncomeOnlineViewController alloc] init];
    } else if (index == 2) {
        VC = [[IncomeCardViewController alloc] init];
    }
    
    if (VC != nil) {
        [self.navigationController pushViewController:VC animated:YES];
    }
}


#pragma mark - private methods

- (void)RACProgress {
    
}

- (void)setUIContent {

    self.title = @"资金记录";
}

- (void)setViewsMASConstraint {
    UIView *superView = self.view;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(4);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(superView);
    }];
}

#pragma mark - getters and settters

- (UIView *)headerView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 48.0;
        _tableView.rowHeight = 48.0;
        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.showsVerticalScrollIndicator = NO;
        
        UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
        [_tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:footerView];
    }
    
    return _tableView;
}

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[@[@"Consumption sub-Run",@"消费返润"],@[@"Order income",@"在线订单收入"],@[@"The line card1",@"线下刷卡"]];
    }
    return _dataSource;
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    [self viewDidLoad];
    [self.tableView reloadData];
}


@end
