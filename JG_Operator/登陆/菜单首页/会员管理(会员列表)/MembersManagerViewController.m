//
//  MembersManagerViewController.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "MembersManagerViewController.h"
#import "XKJHMemberTableViewCell.h"
#import <MJRefresh.h>
#import "MembersManagerViewModel.h"
#import "NodataShowView.h"


@interface MembersManagerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _page;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) MembersManagerViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *personalBtn;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (nonatomic, strong) UIView *selectMenuView;

@property (nonatomic, strong) NodataShowView *noDataView;

@end

static NSString *memberTabelViewCell = @"memberTabelViewCell";

@implementation MembersManagerViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.registerBtn.selected) //注册信息
    {
        if (self.dataSource.count == 0) {
            self.noDataView = [NodataShowView showInContentView:self.tableView withReloadBlock:^{
                [self.tableView.header beginRefreshing];
            } requestResultType:NoDataType];
        }else
        {
            [self.noDataView hide];
        }
        return self.dataSource.count;
    }
    if (self.viewModel.dataSource.count == 0) {
        self.noDataView = [NodataShowView showInContentView:self.tableView withReloadBlock:^{
            [self.tableView.header beginRefreshing];
        } requestResultType:NoDataType];
    }else
    {
        [self.noDataView hide];
    }
    return self.viewModel.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKJHMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:memberTabelViewCell];
    if (self.registerBtn.selected) //注册信息
    {
        if (self.dataSource.count > indexPath.row) {
            [cell willCustomRegisterWith:self.dataSource[indexPath.row]];
        }
    }else
    {
        [cell willCustomCellWith:self.viewModel.dataSource[indexPath.row]];
    }
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
}
#pragma mark - 网络请求注册会员信息
- (void)requestRegisterData
{
    OperatorRegisterListRequest *registerRequest = [[OperatorRegisterListRequest alloc] init:GetToken];
    registerRequest.api_pageNum = @(_page);
    registerRequest.api_pageSize = @(8);
    WEAK_SELF
    [[[VApiManager alloc] init] operatorRegisterList:registerRequest success:^(AFHTTPRequestOperation *operation, OperatorRegisterListResponse *response) {
        for (NSDictionary *dict in response.operatorRegisterList) {
            [weak_self.dataSource addObject:dict];
        }
        [weak_self.tableView reloadData];
        [weak_self.tableView.header endRefreshing];
        if (response.operatorRegisterList.count == 0) {
            [weak_self.tableView.footer noticeNoMoreData];
        }
        else
        {
            [weak_self.tableView.footer endRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self.tableView reloadData];
        weak_self.viewModel.error = error;
        [weak_self.tableView.header endRefreshing];
        [weak_self.tableView.footer endRefreshing];
    }];
}

- (void)bindViewModel
{
    [super bindViewModel];
    self.registerBtn.selected = YES;
    WEAK_SELF
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weak_self.tableView.footer resetNoMoreData];
        if (weak_self.registerBtn.selected) //请求注册信息
        {
            _page = 1;
            [weak_self.dataSource removeAllObjects];
            [weak_self requestRegisterData];
        }
        else                //请求所属信息
        {
            [weak_self.viewModel.headerRefreshCommand execute:nil];
        }
        
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (weak_self.registerBtn.selected) //请求注册信息
        {
            _page += 1;
            [weak_self requestRegisterData];
        }
        else                //请求所属信息
        {
            [weak_self.viewModel.footerRefreshCommand execute:nil];
        }
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
    
    @weakify(self);
    [RACObserve(self.viewModel, dataSource) subscribeNext:^(NSArray *data) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    [self.tableView.header beginRefreshing];
}

- (void)setUIAppearance
{
    [super setUIAppearance];
    [Util setNavTitleWithTitle:@"会员管理" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 130;
    [self.tableView registerNib:[UINib nibWithNibName:@"XKJHMemberTableViewCell" bundle:nil] forCellReuseIdentifier:memberTabelViewCell];

    self.selectMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.menuView.frame) - 3, kScreenWidth / 2 , 3)];
    self.selectMenuView.backgroundColor = status_color;
    [self.menuView addSubview:self.selectMenuView];
    
}
- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 注册会员
- (IBAction)registerAction:(UIButton *)sender
{
    [self selectMenuAction:sender];
}
#pragma mark - 所属会员
- (IBAction)personalAction:(UIButton *)sender
{
    [self selectMenuAction:sender];
}
- (void) selectMenuAction:(UIButton *)menu
{
    self.registerBtn.selected = NO;
    self.personalBtn.selected = NO;
    menu.selected = YES;
    WEAK_SELF
    CGRect frame = self.selectMenuView.frame;
    frame.origin.x = kScreenWidth / 2 * menu.tag;
    [UIView animateWithDuration:0.3 animations:^{
        weak_self.selectMenuView.frame = frame;
    }];
    [self.tableView reloadData];
    [self.tableView.header beginRefreshing];
}

- (MembersManagerViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[MembersManagerViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark - debug operation
- (void)updateOnClassInjection {
    [self.viewModel.headerRefreshCommand execute:nil];
}
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end
