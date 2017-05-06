
//
//  XKJHMemberLIitViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHMemberLIitViewController.h"
#import "XKJHMemberTableViewCell.h"
#import <MJRefresh.h>

#import "XKJHShopEnterInfoViewController.h"
#import "XKJHCouponDetailsViewController.h"
#import "XKJHOrderCouponDetailsViewController.h"

@interface XKJHMemberLIitViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSInteger _page;
    VApiManager *_vapiManager;
}

@property (weak, nonatomic  ) IBOutlet UITextField    *searchMobile;
@property (weak, nonatomic  ) IBOutlet UILabel        *countLabel;
@property (weak, nonatomic  ) IBOutlet UITableView    *tableView;


//@property (nonatomic, strong) UIButton       *rightBtn;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

static NSString *memberTabelViewCell = @"memberTabelViewCell";

@implementation XKJHMemberLIitViewController

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKJHMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:memberTabelViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataSource.count != 0) {
        [cell willCustomCellWith:self.dataSource[indexPath.row]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)requestData
{
    WEAK_SELF
    GroupStoreCustomerListRequest *listRequest = [[GroupStoreCustomerListRequest alloc] init:GetToken];
    listRequest.api_mobile = self.searchMobile.text;
    listRequest.api_pageNum = @(_page);
    listRequest.api_pageSize = @(10);
    [_vapiManager groupStoreCustomerList:listRequest success:^(AFHTTPRequestOperation *operation, GroupStoreCustomerListResponse *response) {
        NSLog(@"cheshi ---- %@",response);
        for (NSDictionary *dict in response.storeCustomerList)
        {
            [weak_self.dataSource addObject:dict];
        }
        [weak_self.tableView.header endRefreshing];
        if (response.storeCustomerList.count > 0)
        {
            [weak_self.tableView.footer endRefreshing];
        }
        else
        {
            [weak_self.tableView.footer noticeNoMoreData];
        }
        self.countLabel.text = [NSString stringWithFormat:@"会员总数：%@个",response.customerTotal];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        NSLog(@"cheshi ---- %@",error);
    }];
}
- (void)initUI
{
    self.view.backgroundColor = VCBackgroundColor;
    self.navigationController.navigationBar.barTintColor = status_color;
    [Util setNavTitleWithTitle:@"会员管理" ofVC:self];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.dataSource = [NSMutableArray array];
    _vapiManager = [[VApiManager alloc] init];
    
    WEAK_SELF
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self.dataSource removeAllObjects];
        [weak_self requestData];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [weak_self requestData];
    }];

    [self.tableView.header beginRefreshing];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 130;
    [self.tableView registerNib:[UINib nibWithNibName:@"XKJHMemberTableViewCell" bundle:nil] forCellReuseIdentifier:memberTabelViewCell];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (![Util isValidateMobile:self.searchMobile.text] && self.searchMobile.text.length != 0) {
        [Util ShowAlertWithOnlyMessage:@"您输入的电话号码有误"];
        return NO;
    };
    [self.tableView.header beginRefreshing];
    return YES;
}

- (void)rightAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
}



@end
