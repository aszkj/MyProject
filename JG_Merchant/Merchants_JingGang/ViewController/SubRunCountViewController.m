//
//  SubRunCountViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "SubRunCountViewController.h"
#import "SubRunDetailTableViewCell.h"
#import "DebugSet.h"
#import "TableViewModel.h"

@interface SubRunCountViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) TableViewModel *viewModel;

@end

@implementation SubRunCountViewController
static NSString *cellIdentifier = @"SubRunDetailTableViewCell";

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
    [RACObserve(self.viewModel, dataSource) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    WEAK_SELF;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weak_self.viewModel.footerRefreshCommand execute:nil];
//        [weak_self.tableView.footer resetNoMoreData];
    }];
    [self.viewModel.footerRefreshCommand.executing subscribeNext:^(NSNumber *isExcuting) {
        @strongify(self);
        if (!isExcuting.boolValue)   [self.tableView.footer endRefreshing];
//        if (self.viewModel.isNoMoreData) {
//            [self.tableView.footer noticeNoMoreData];
//        }
    }];
    [self.tableView.footer beginRefreshing];
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
    SubRunDetailTableViewCell *detailCell = (SubRunDetailTableViewCell *)cell;
    [detailCell configData:self.viewModel.dataSource[indexPath.row]];
}


#pragma mark - CustomDelegate



#pragma mark - event response



#pragma mark - private methods
- (void)setUIContent {
    self.title = @"返润明细列表";
}

- (void)setViewsMASConstraint {
    UIView *superView = self.view;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(5);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(superView);
    }];
}

#pragma mark - getters and settters
- (TableViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TableViewModel alloc] init];
        _viewModel.footerSelector = @selector(shareDetailSignal);
    }
    return _viewModel;
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 48.0;
        _tableView.rowHeight = 48.0;
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
    [self viewDidLoad];
    [DebugSet showExplor];
}


@end
