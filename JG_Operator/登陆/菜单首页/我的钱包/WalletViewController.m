//
//  WalletViewController.m
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "WalletViewController.h"
#import "CustomBasicTableViewCell.h"
#import "WalletViewModel.h"
#import "TakeMoneyViewController.h"
#import "TakeDetailViewController.h"
#import "EarningDetailViewController.h"
#import "ExpectProfitViewController.h"

@interface WalletViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) WalletViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *yunbiLable;
@property (weak, nonatomic) IBOutlet UIButton *takeButton;

@end

static NSString *cellIdentifier = @"CustomBasicTableViewCell";

@implementation WalletViewController

- (WalletViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[WalletViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel getYunbiResques];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self);
    RAC(self.yunbiLable,attributedText) = RACObserve(self.viewModel, yunbiString);
    [[self.takeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        TakeMoneyViewController *VC = [[TakeMoneyViewController alloc] initWithNibName:@"TakeMoneyViewController" bundle:nil];
        [self showNextViewController:VC];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.viewModel.active = NO;
}
#pragma mark - 设置UI外观

- (void)setUIAppearance {
    [super setUIAppearance];
    UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
    self.tableView.separatorColor = [UIColor clearColor];
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:footerView];
}

#pragma mark - 界面跳转
- (void)showNextViewController:(UIViewController *)VC {
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *VC;
    if (indexPath.row == 0) {
        VC = [[TakeDetailViewController alloc] initWithNibName:@"TakeDetailViewController" bundle:nil];
    } else if (indexPath.row == 1) {
        VC = [[EarningDetailViewController alloc] initWithNibName:@"EarningDetailViewController" bundle:nil];
    } else if (indexPath.row == 2){
        VC = [[ExpectProfitViewController alloc] initWithNibName:@"ExpectProfitViewController" bundle:nil];
    }
    else if (indexPath.row == 2)
    {
        VC = [[ExpectProfitViewController alloc] initWithNibName:@"ExpectProfitViewController" bundle:nil];
    }
    [self showNextViewController:VC];
}

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

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    //这里把数据设置给Cell
    CustomBasicTableViewCell *customCell = (CustomBasicTableViewCell *)cell;
    customCell.basicTitle.text = self.viewModel.dataSource[indexPath.row];
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    self.tableView.fd_debugLogEnabled = YES;
    [self.tableView reloadData];
    [DebugSet showExplor];
}

@end
