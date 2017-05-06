//
//  TakeRecordViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "TakeRecordViewController.h"
#import "TakeRecordTableViewCell.h"
#import "DebugSet.h"
#import "UIView+Loading.h"
#import "TableViewModel.h"

@interface TakeRecordViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) TableViewModel *viewModel;

@end

@implementation TakeRecordViewController

static NSString *cellIdentifier = @"TakeRecordTableViewCell";

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
    [super bindViewModel];
    @weakify(self);
    WEAK_SELF
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weak_self.tableView.footer resetNoMoreData];
        [weak_self.viewModel.headerRefreshCommand execute:nil];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weak_self.viewModel.footerRefreshCommand execute:nil];
    }];
    
    [[[self.viewModel.headerRefreshCommand executing] distinctUntilChanged]subscribeNext:^(NSNumber *isExcuting) {
        if (![isExcuting boolValue])
        {
            [self.tableView.header endRefreshing];
        }
    }];
    [[[self.viewModel.footerRefreshCommand executing] distinctUntilChanged]subscribeNext:^(NSNumber *isExcuting) {
        if (![isExcuting boolValue])
        {
            if (self.viewModel.isNoMoreData)
            {
                [self.tableView.footer noticeNoMoreData];
            }
            else
            {
                [self.tableView.footer endRefreshing];
            }
        }
    }];
    
    [RACObserve(self.viewModel, dataSource) subscribeNext:^(NSArray *data) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    [self.tableView.header beginRefreshing];
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
    return self.viewModel.dataSource.count;
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
    TakeRecordTableViewCell *takeCell = (TakeRecordTableViewCell *)cell;
    [takeCell configData:self.viewModel.dataSource[indexPath.row]];
}


#pragma mark - CustomDelegate



#pragma mark - event response



#pragma mark - private methods

- (void)setUIContent {
    self.title = @"提现记录";
    self.view.backgroundColor = background_Color;
}

- (void)setViewsMASConstraint {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(5);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - getters and settters
- (TableViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TableViewModel alloc] init];
        _viewModel.footerSelector = @selector(takeListAddSignal);
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 95.5;
        _tableView.rowHeight = 95.5;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        
        UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
        [_tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:footerView];
    }
    
    return _tableView;
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    [self.tableView reloadData];
    [DebugSet showExplor];
    self.tableView.fd_debugLogEnabled = YES;
}


@end
