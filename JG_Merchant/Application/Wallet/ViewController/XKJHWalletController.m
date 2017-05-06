//
//  XKJHWalletController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHWalletController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CustomBasicTableViewCell.h"
#import "DebugSet.h"
#import "TakeMoneyViewController.h"
#import "TakeRecordViewController.h"
#import "MoneyRecordViewController.h"
#import "UIViewController+Extension.h"
#import "UIView+Loading.h"
#import "MerchantClient.h"
#import "RTTakeMoneyViewModel.h"
#import "ChangYunbiPasswordViewController.h"

@interface TableDataSource : NSObject
@property (nonatomic) UIViewController *VC;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *title;

- (instancetype)initWithVC:(UIViewController *)VC image:(UIImage *)image title:(NSString *)title;
@end

@implementation TableDataSource
- (instancetype)initWithVC:(UIViewController *)VC image:(UIImage *)image title:(NSString *)title
{
    if (self = [super init]) {
        self.VC = VC;
        self.image = image;
        self.title = title;
    }
    return self;
}

@end

@interface XKJHWalletController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UIImageView *backImageView;
@property (nonatomic) UILabel *yunbiLabel;
@property (nonatomic) UIButton *takeButton;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSString *errorDescription;
@property (nonatomic) NSArray *dataSource;

@property (strong, nonatomic) RTTakeMoneyViewModel *viewModel;

@end

@implementation XKJHWalletController

static NSString *cellIdentifier = @"CustomBasicTableViewCell";

-(id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.yunbiLabel];
    [self.view addSubview:self.takeButton];
    [self.view addSubview:self.tableView];
    
    [self setUIContent];
    [self setViewsMASConstraint];
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    [self.viewModel.getYunbiCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if ([executing boolValue]) {
            [self.view showLoading];
        }else {
            [self.view hideLoading];
        }
    }];

    [RACObserve(self.viewModel, balance) subscribeNext:^(NSNumber *balance) {
        @strongify(self)
        [self setYunbiNumber:balance];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
    self.hidesBottomBarWhenPushed = NO;
    self.viewModel.active = YES;
    [self.viewModel.getYunbiCommand execute:nil];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animate {
    [super viewWillDisappear:animate];
    self.viewModel.active = NO;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hiddenBottomBar];
    TableDataSource *tableData = self.dataSource[indexPath.section];
    [self.navigationController pushViewController:tableData.VC animated:YES];
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
    TableDataSource *tableData = self.dataSource[indexPath.section];
    basicCell.leftImageView.image = tableData.image;
    basicCell.basicTitle.text = tableData.title;
}

#pragma mark - CustomDelegate



#pragma mark - event response

- (void)showTakeAction {
    [self hiddenBottomBar];
    TakeMoneyViewController *VC = [[TakeMoneyViewController alloc] initWithNibName:@"TakeMoneyViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - private methods

- (void)RACProgress {
}

- (void)setBarButtonItem {

}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    navBar.barTintColor = status_color;
    navBar.translucent = NO;
}

- (void)setUIContent {
    [self setNavigationBar];
    [self setBarButtonItem];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"钱包";
    self.view.backgroundColor = background_Color;
    [self setYunbiNumber:@(0.00)];

}

- (void)setViewsMASConstraint {
    
    UIView *superView = self.view;
    [self.backImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(superView);
        make.height.equalTo(@(113));
    }];
    [self.yunbiLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backImageView);
    }];
    [self.takeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView.mas_bottom).with.offset(16);
        make.centerX.equalTo(superView);
        make.width.equalTo(@(110));
        make.height.equalTo(@(31));
    }];
    UIView *lineView = [self lineView:[UIColor lightGrayColor]];
    [superView addSubview:lineView];
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView.mas_bottom).with.offset(62);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(0.5));
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(lineView.mas_bottom).with.offset(15);
        make.bottom.equalTo(superView);
    }];
}

#pragma mark - getters and settters

- (RTTakeMoneyViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[RTTakeMoneyViewModel alloc] init];
    }
    return _viewModel;
}

- (UIView *)lineView:(UIColor *)viewColor {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = viewColor;
    return lineView;
}

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        TableDataSource *takeRecord = [[TableDataSource alloc] initWithVC:[[MoneyRecordViewController alloc] init] image:[UIImage imageNamed:@"Funds"] title:@"资金记录"];
        TableDataSource *moneyRecord = [[TableDataSource alloc] initWithVC:[[TakeRecordViewController alloc] init] image:[UIImage imageNamed:@"withdraw"] title:@"提现记录"];
        TableDataSource *changePassword = [[TableDataSource alloc] initWithVC:[[ChangYunbiPasswordViewController alloc] initWithNibName:@"ChangYunbiPasswordViewController" bundle:nil] image:[UIImage imageNamed:@"ChangePassword"] title:@"修改提现密码"];
        return @[takeRecord,moneyRecord,changePassword];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 49.0;
        _tableView.rowHeight = 49.0;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
        [_tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
        [_tableView setTableHeaderView:[self headerView]];
    }

    return _tableView;
}

- (UIButton *)takeButton {
    if (_takeButton == nil) {
        _takeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _takeButton.backgroundColor = status_color;
        _takeButton.tintColor = [UIColor whiteColor];
        [_takeButton setTitle:@"我要提现" forState:UIControlStateNormal];
        _takeButton.layer.cornerRadius = 15.0;
        [_takeButton addTarget:self action:@selector(showTakeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takeButton;
}

- (UIImageView *)backImageView {
    if (_backImageView == nil) {
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
    }
    return _backImageView;
}

- (void)setYunbiNumber:(NSNumber *)totalYunbi {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"云币 \n %.2f",[totalYunbi doubleValue]]];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:15.0],NSFontAttributeName,
                                   [UIColor whiteColor],NSForegroundColorAttributeName,
                                   nil
                                   ];
    NSRange range = [attributedString.string rangeOfString:@"云币"];
    [attributedString addAttributes:attributeDict range:range];
    attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                     [UIFont systemFontOfSize:32.0],NSFontAttributeName,
                     [UIColor whiteColor],NSForegroundColorAttributeName,
                     nil
                     ];
    range = NSMakeRange(range.length, attributedString.length-range.length);
    [attributedString addAttributes:attributeDict range:range];
    self.yunbiLabel.hidden = NO;
    self.yunbiLabel.attributedText = attributedString.copy;
}

- (UILabel *)yunbiLabel {
    if (_yunbiLabel == nil) {
        _yunbiLabel = [[UILabel alloc] init];
        _yunbiLabel.numberOfLines = 2;
        _yunbiLabel.hidden = YES;
        _yunbiLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _yunbiLabel;
}

- (UIView *)headerView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    [self viewDidLoad];
    [_tableView reloadData];
    [DebugSet showExplor];
}

@end
