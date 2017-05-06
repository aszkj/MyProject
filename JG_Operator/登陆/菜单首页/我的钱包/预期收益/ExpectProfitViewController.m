//
//  ExpectProfitViewController.m
//  Operator_JingGang
//
//  Created by thinker on 15/11/9.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ExpectProfitViewController.h"
#import "RTTitleSelectorView.h"
#import "NSString+BlankString.h"
#import "HorizonTableViewCell.h"
#import "NodataShowView.h"

@interface ExpectProfitViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) VApiManager *vapiManager;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet RTTitleSelectorView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;

@end

NSString *expectCell = @"HorizonTableViewCell";

@implementation ExpectProfitViewController

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count == 0) {
        [NodataShowView showInContentView:tableView withReloadBlock:^{
            [tableView.header beginRefreshing];
        } requestResultType:No_ExpectType];
    }
    else
    {
        [NodataShowView hideInContentView:tableView];
    }
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HorizonTableViewCell *horizonCell = [tableView dequeueReusableCellWithIdentifier:expectCell];
    [horizonCell cleanSubView];
    NSDictionary *dict = self.dataSource[indexPath.row]; //OperatorProfitList
    UILabel *storeNameLabel = [self createLabelWithFont:[UIFont systemFontOfSize:11.0] fontColor:KColorText666666 text:dict[@"storeName"]];
    UILabel *moneyLabel = [self createLabelWithFont:[UIFont systemFontOfSize:11.0] fontColor:KColorText666666 text:kNumberToStr(@([dict[@"rebateAmount"] doubleValue]))];
    UILabel *timeLabel = [self createLabelWithFont:[UIFont systemFontOfSize:11.0] fontColor:KColorText666666 text:dict[@"createTime"]];
    UILabel *typeLabel = [self createLabelWithFont:[UIFont systemFontOfSize:11.0] fontColor:KColorText666666 text:dict[@"rebateTypeName"]];

    
    [self insertArrangedSubview:storeNameLabel atIndex:0 stackView:horizonCell.stackView];
    [self insertArrangedSubview:timeLabel atIndex:1 stackView:horizonCell.stackView];
    [self insertArrangedSubview:moneyLabel atIndex:2 stackView:horizonCell.stackView];
    [self insertArrangedSubview:typeLabel atIndex:3 stackView:horizonCell.stackView];
    
    [horizonCell layoutStackView];
    if (indexPath.row%2 == 0) {
        horizonCell.stackView.backgroundColor = [UIColor whiteColor];
    } else {
        horizonCell.stackView.backgroundColor = UIColorFromRGB(0xe7e7e7);
    }
    return horizonCell;
}
- (void)insertArrangedSubview:(UILabel *)subview atIndex:(NSInteger)index stackView:(OAStackView *)stackView
{
    [subview setAdjustsFontSizeToFitWidth:NO];
    subview.textAlignment = NSTextAlignmentCenter;
    subview.numberOfLines = 2;
    [stackView insertArrangedSubview:subview atIndex:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)requestData
{
    XKO_EarningDetailRequestInfo *info = [[XKO_EarningDetailRequestInfo alloc] init];
    info.api_pageNum = @(_page);
    info.api_pageSize = @(10);
    WEAK_SELF
    [self.dataCenter requestOperatorExpectProfitListFromModel:info successBlk:^(NSArray *responseData) {
        OperatorExpectProfitListResponse *response = (OperatorExpectProfitListResponse *) responseData[0];
        weak_self.priceLabel.text = [NSString stringWithFormat:@"预期收益总额：%.2f",response.expectProfitTotal.doubleValue];
        for ( NSDictionary *dict in response.expectProfit) {
            [weak_self.dataSource addObject:dict];
        }
        [weak_self.tableView reloadData];
        [weak_self.tableView.header endRefreshing];
        if (response.expectProfit.count == 0) {
            [weak_self.tableView.footer noticeNoMoreData];
        }
        else
        {
            [weak_self.tableView.footer endRefreshing];
        }
    } failBlk:^(NSError *error) {
        [weak_self.tableView.header endRefreshing];
        [weak_self.tableView.footer endRefreshing];
        [weak_self errorHandle:error];
    }];
    
 
}

-(void)setUIAppearance
{
    [super setUIAppearance];
    self.dataSource = [NSMutableArray array];
    [Util setNavTitleWithTitle:@"预期收益" ofVC:self];
    self.titleView.titlesArray = @[@"商户名称",@"交易时间",@"收益金额",@"收益类型"];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"HorizonTableViewCell" bundle:nil] forCellReuseIdentifier:expectCell];
    self.tableView.rowHeight = 45.5;

    self.page = 1;
    WEAK_SELF
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weak_self.tableView.footer resetNoMoreData];
        weak_self.page = 1;
        [weak_self.dataSource removeAllObjects];
        [weak_self requestData];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weak_self.page += 1;
        [weak_self requestData];
    }];
    [self.tableView.header beginRefreshing];
    
}

- (VApiManager *)vapiManager
{
    if (_vapiManager == nil) {
        _vapiManager = [[VApiManager alloc] init];
    }
    return _vapiManager;
}

@end
