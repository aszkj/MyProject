//
//  TakeDetailViewController.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "TakeDetailViewController.h"
#import "TakeDetailViewModel.h"
#import "RTTitleSelectorView.h"
#import "HorizonTableViewCell.h"
#import "XKO_TakeDetailResponseInfo.h"

@interface TakeDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet RTTitleSelectorView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) TakeDetailViewModel *viewModel;

@end

static NSString *cellIdentifier = @"HorizonTableViewCell";

@implementation TakeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    [super bindViewModel];
    RAC(self.titleView,titlesArray) = RACObserve(self.viewModel, titleArray);
    UILabel *footerLabel = (UILabel *)self.tableView.tableFooterView;
    RAC(footerLabel,text) = RACObserve(self.viewModel, footerText);
    [self bindTableViewModel];
}

- (void)bindTableViewModel {
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
    
    @weakify(self);
    [RACObserve(self.viewModel, dataSource) subscribeNext:^(NSArray *data) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    [self.tableView.header beginRefreshing];
}

- (void)setUIAppearance {
    [super setUIAppearance];
    
    UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
    self.tableView.separatorColor = [UIColor clearColor];
    UILabel *footerView = [self createLabelWithFont:[UIFont systemFontOfSize:12.0] fontColor:KColorText999999 text:@"如需收益明细列, 表请登陆云e生WEB端后台查看详情"];
    [footerView setFrame:CGRectMake(10, 0, kScreenWidth, 30)];
    footerView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:footerView];
    [self.tableView setBackgroundColor:self.view.backgroundColor];
}

- (TakeDetailViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TakeDetailViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [self loadCellContent:cell indexPath:indexPath];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (void)insertArrangedSubview:(UILabel *)subview atIndex:(NSInteger)index stackView:(OAStackView *)stackView
{
    [subview setAdjustsFontSizeToFitWidth:NO];
    subview.textAlignment = NSTextAlignmentCenter;
    subview.numberOfLines = 2;
    [stackView insertArrangedSubview:subview atIndex:index];
}

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    //这里把数据设置给Cell
    HorizonTableViewCell *horizonCell = (HorizonTableViewCell *)cell;
    [horizonCell cleanSubView];
    
    XKO_TakeDetailResponseInfo *takeDetailModel = self.viewModel.dataSource[indexPath.row];
    UILabel *moneyLabel = [self createLabelWithFont:[UIFont systemFontOfSize:11.0] fontColor:KColorText666666 text:[NSString stringWithFormat:@"%.2f",takeDetailModel.cashAmount.doubleValue]];
    UILabel *timeLabel = [self createLabelWithFont:[UIFont systemFontOfSize:11.0] fontColor:KColorText666666 text:takeDetailModel.addTime];
    UILabel *statusLabel = [self createLabelWithFont:[UIFont systemFontOfSize:11.0] fontColor:KColorText666666 text:takeDetailModel.cashStatusString];
    
    [self insertArrangedSubview:moneyLabel atIndex:0 stackView:horizonCell.stackView];
    [self insertArrangedSubview:timeLabel atIndex:1 stackView:horizonCell.stackView];
    [self insertArrangedSubview:statusLabel atIndex:2 stackView:horizonCell.stackView];
    
    [horizonCell layoutStackView];
    if (indexPath.row%2 == 0) {
        horizonCell.stackView.backgroundColor = [UIColor whiteColor];
    } else {
        horizonCell.stackView.backgroundColor = UIColorFromRGB(0xe7e7e7);
    }
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    [DebugSet showExplor];
    [self.tableView reloadData];
}

@end
