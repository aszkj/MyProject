//
//  WSJOrderCouponDetailsViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/1.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOrderCouponDetailsViewController.h"
#import "XKJHOrderDetailsHeaderView.h"
#import "XKJHOrderTetailsTableViewCell.h"

CGFloat orderTableViewRowHeight = 90;


@interface XKJHOrderCouponDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    VApiManager *_vapiManager;
}

@property (weak, nonatomic) IBOutlet UILabel *orderNameLabel;//订单券名称
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;//背景图
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;//订单券状态
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;//订单券金额
@property (weak, nonatomic) IBOutlet UILabel *effectiveTimeLabel;//订单券有效时间

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

static NSString *orderCouponDetailCell = @"orderCouponDetailCell";

@implementation XKJHOrderCouponDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
}
- (void)requestData
{
    NSLog(@"cheshi ---- %@",self.api_orderId);
    WEAK_SELF
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    [hud show:YES];
    GroupOrderDetailsRequest *orderDetailsRequest = [[GroupOrderDetailsRequest alloc] init:GetToken];
    orderDetailsRequest.api_orderId = self.api_orderId;
    [_vapiManager groupOrderDetails:orderDetailsRequest success:^(AFHTTPRequestOperation *operation, GroupOrderDetailsResponse *response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (response.subCode > 0)
        {
            return ;
        }
        GroupOrder *orderBO = [GroupOrder objectWithKeyValues:response.groupOrderBO];
        NSLog(@"cheshi ---- %@",response);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            XKJHOrderDetailsHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"XKJHOrderDetailsHeaderView" owner:self options:nil][0];
            headerView.orderNumber.text = orderBO.orderId;
            headerView.titleLabel.text = orderBO.groupService.goodsName;
            headerView.orderTimeLabel.text = [NSString stringWithFormat:@"%@",orderBO.addTime];
            headerView.nameLabel.text = orderBO.nickName;
            headerView.phoneLabel.text = orderBO.mobile;
            weak_self.tableView.tableHeaderView = headerView;
            weak_self.orderNameLabel.text = orderBO.groupService.goodsName;
            weak_self.orderPriceLabel.text = [NSString stringWithFormat:@"%.2f元",[orderBO.totalPrice floatValue]];
            weak_self.effectiveTimeLabel.text = [NSString stringWithFormat:@"%@-%@",[weak_self getStringWithDate:orderBO.groupService.goodBeginTime],[weak_self getStringWithDate:orderBO.groupService.goodsEndTime]];
            
        });
        for (NSDictionary *dict in orderBO.groupInfoBOs)
        {
            [self.dataSource addObject:dict];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"cheshi ---- %@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (NSString *)getStringWithDate:(NSDate *)Date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@",Date]];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    return [formatter stringFromDate:date];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKJHOrderTetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCouponDetailCell];
    [cell willCustomCellWith:self.dataSource[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (void)initUI
{
    _vapiManager = [[VApiManager alloc] init];
    self.dataSource = [NSMutableArray array];
    [Util setNavTitleWithTitle:@"订单详情" ofVC:self];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    self.view.backgroundColor = VCBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.rowHeight = orderTableViewRowHeight;
    [self.tableView registerNib:[UINib nibWithNibName:@"XKJHOrderTetailsTableViewCell" bundle:nil] forCellReuseIdentifier:orderCouponDetailCell];
}

//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
