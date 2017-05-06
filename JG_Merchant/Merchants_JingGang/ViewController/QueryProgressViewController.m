//
//  QueryProgressViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "QueryProgressViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "QueryLogisticsTableViewCell.h"
#import "DebugSet.h"
#import "XKJHShopEnterInfoViewController.h"
#import "QueryProgressViewModel.h"
#import "UIView+Loading.h"
#import "KJLoginController.h"
@interface QueryProgressViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataSource;
@property (nonatomic) NSInteger currentStep;
@property (nonatomic) QueryProgressViewModel *viewModel;
@property (nonatomic) BOOL hasFail;

@end

@implementation QueryProgressViewController
static NSString *cellIdentifier = @"QueryLogisticsTableViewCell";

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
}

- (void)bindViewModel {
    
    @weakify(self);
    //发出request
    [self.viewModel.queryProgressCommand execute:nil];
    [self.viewModel.queryProgressCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if ([executing boolValue]) {
            [self.navigationController.view showLoading];
        }else {
            [self.navigationController.view hideLoading];
        }
    }];
    //刷新tableView
    [[RACObserve(self.viewModel, applyInfo) filter:^BOOL(id value) {
        return value != nil;
    }]  subscribeNext:^(StoreApplyInfo *applyInfo) {
        [RACObserve(self.viewModel.applyInfo, storeStatus) subscribeNext:^(NSNumber *storeStatus) {
            @strongify(self);
            if (storeStatus.integerValue == 0) {
                self.currentStep = 1;
            } else if (storeStatus.integerValue == 1||storeStatus.integerValue == 2) {
                self.currentStep = 2;
            } else if (storeStatus.integerValue == 5||storeStatus.integerValue == 6) {
                self.currentStep = 3;
            } else if (storeStatus.integerValue == 15) {
                self.currentStep = 4;
            }
        }];
        [RACObserve(self.viewModel.applyInfo, failReseaon) subscribeNext:^(NSString *value) {
            if (value.length > 0) { self.hasFail = YES;  }
            else {  self.hasFail = NO;  }
            [self.tableView setTableFooterView:[self editButton]];
        }];
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }];
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

- (CGFloat)getHeightTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
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
    QueryLogisticsTableViewCell *queryCell = (QueryLogisticsTableViewCell *)cell;
    queryCell.detailTitle.text = self.dataSource[indexPath.row];
    
    if (indexPath.row == self.dataSource.count-1) {
        if (self.currentStep == self.dataSource.count && self.hasFail == NO) {
            [queryCell isLastObjecLineColor:status_color pointColor:status_color];
        } else if (self.currentStep == self.dataSource.count && self.hasFail == YES) {
            [queryCell isLastObjecLineColor:status_color pointColor:[UIColor redColor]];
        } else {
            [queryCell isLastObjecLineColor:[UIColor lightGrayColor] pointColor:[UIColor lightGrayColor]];
        }
    } else if (indexPath.row < self.currentStep-1) {
        [queryCell setheadColor:status_color pointColor:status_color footColor:status_color];
    } else if (indexPath.row == self.currentStep-1) {
        if (self.hasFail) {
            [queryCell setheadColor:status_color pointColor:[UIColor redColor] footColor:[UIColor lightGrayColor]];
            [queryCell setMessage:self.viewModel.applyInfo.failReseaon];
        } else {
            [queryCell setheadColor:status_color pointColor:status_color footColor:[UIColor lightGrayColor]];
        }
    }
    
    if (indexPath.row+1 > self.currentStep && indexPath.row+1 != self.dataSource.count) {
        [queryCell setheadColor:[UIColor lightGrayColor] pointColor:[UIColor lightGrayColor] footColor:[UIColor lightGrayColor]];
    } else if (indexPath.row+1 < self.currentStep && indexPath.row+1 != self.dataSource.count) {
        
    }
    if (indexPath.row == 0) {
        if (self.currentStep == 1) {
            [queryCell isFirstObjectLineColor:[UIColor lightGrayColor] pointColor:status_color];
        } else {
            [queryCell isFirstObjectLineColor:status_color pointColor:status_color];
        }
    }
}

#pragma mark - CustomDelegate



#pragma mark - event response
- (void)goEditVC
{
    DDLogDebug(@"跳转至编辑审核资料界面");
    XKJHShopEnterInfoViewController *VC = [[XKJHShopEnterInfoViewController alloc] initWithNibName:@"XKJHShopEnterInfoViewController" bundle:nil];
    VC.isEdit = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)logoutAndExit {
    [kUserDefaults setObject:@"" forKey:Token];
    [kUserDefaults synchronize];
    exit(0);
}

#pragma mark - private methods

typedef void (^TLRequestResponse)(BOOL);


- (void)setUIContent {
    self.title = @"进度查询";
    self.tableView.hidden = YES;
    self.view.backgroundColor = background_Color;
}

- (void)setViewsMASConstraint {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark - getters and settters

- (QueryProgressViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[QueryProgressViewModel alloc] init];
    }
    return _viewModel;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] initWithArray:@[
                                                              @"提交入住申请",
                                                              @"运营商审核",
                                                              @"云e生审核",
                                                              @"入住成功",
                                                              ]];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 95.5;
        _tableView.rowHeight = 95.5;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;

        UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
        [_tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setTableHeaderView:[self headerView]];
        [_tableView setTableFooterView:[self footerView]];
    }

    return _tableView;
}

- (UIView *)headerView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)editButton
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(12,10,kScreenWidth-24,43)];
    [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editButton setBackgroundColor:[UIColor colorWithRed:22.0/255.0 green:66.0/255.0 blue:99.0/255.0 alpha:1.0]];
    if (self.hasFail) {
        [editButton setTitle:@"编辑审核资料" forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(goEditVC) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [editButton setTitle:@"退出" forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(logoutAndExit) forControlEvents:UIControlEventTouchUpInside];
    }
    [view addSubview:editButton];
    return view;
}

- (UIView *)footerView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    NSDictionary *testDic = @{
                              @"id": @(9),
                              @"isEepay": @(0),
                              @"storeStatus": @(5),
                              };
    self.viewModel.applyInfo = [StoreApplyInfo objectWithKeyValues:testDic];
}

@end
