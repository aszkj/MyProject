//
//  ShoppingOrderDetailController.m
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "ShoppingOrderDetailController.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "urlManagerHeader.h"
#import "OffLineOrderCell.h"
#import "OrderDetailHeader.h"
#import "OrderDetailModel.h"
#import "OrderDetailCell.h"
#import "OrderDetailDynamicCell.h"
#import "OrderDetailAddressCell.h"
#import "UIImageView+WebCache.h"
#import "mapObject.h"
#import "ServiceDetailController.h"
#import "MBProgressHUD.h"
#import "XKJHMapViewController.h"
#import "MJExtension.h"
#import "JGOrderDtailCell.h"
#import "JGOrderDetailHeaderView.h"
#import "JGDropdownMenu.h"
#import "ServiceDetailController.h"
#import "ApplySalesReturnVC.h"

@interface ShoppingOrderDetailController ()<UIWebViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *orderDetailDataSource;
@property (nonatomic, strong) NSMutableArray *serviceListDataSource;
@property (nonatomic, strong) VApiManager *vapManager;

@property (strong, nonatomic) NSString *shopName;
@property (strong, nonatomic) NSString *telephone;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *distance;
@property(nonatomic,assign) NSInteger orderType;
@property (strong, nonatomic) UILabel *consumeState;
@property (strong, nonatomic) NSString *groupSn;
@property (strong, nonatomic) UIButton *refundBtn;

@property (strong, nonatomic) POrderDetails *pOrderDetail;

@property (strong,nonatomic) JGOrderDetailHeaderView *headrView;

@property (assign, nonatomic) NSInteger status;


/***  已选中退款项 */
@property (strong,nonatomic) NSIndexPath *refundIndexPath;

/**
 *  个人订单详情信息 */
@property (strong,nonatomic) PersonalOrderDetailsResponse *response;

@end

@implementation ShoppingOrderDetailController

-(instancetype)initWithStatus:(NSInteger)status {
    if (self = [super init]) {
        self.status = status;
    }
    return self;
}

- (void)setControllerType:(DetailControllerType)controllerType {
    _controllerType = controllerType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.wantsFullScreenLayout = NO;
    CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.contentInset = UIEdgeInsetsMake(-40, 0, 0, 0);
    _tableView.contentOffset = CGPointMake(0, 0);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    [self _loadTitleView];
    [self _requestPersonalOrderDetails];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma getter

- (VApiManager *)vapManager
{
    if (!_vapManager) {
        _vapManager = [[VApiManager alloc] init];
    }
    return _vapManager;
}

#pragma mark - private methord
#pragma mark- 初始化UI界面

- (void)initUI
{
    //设置背景颜色
    self.view.backgroundColor = VCBackgroundColor;
    if (self.controllerType == ControllerServicePayType) {
        [self setupNavBarPopButton];
        return;
    }
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"取消" titleColor:[UIColor whiteColor] target:self action:@selector(goRoot)];
}

- (void)backToLastController {
    [self.navigationController popToViewController:[self.navigationController.viewControllers xf_safeObjectAtIndex:1] animated:YES];
}

- (void)initData
{

    OrderDetailModel *detail1 = [[OrderDetailModel alloc] init];
    detail1.title = @"订单编号:";
    detail1.content = @"";
    
    OrderDetailModel *detail2 = [[OrderDetailModel alloc] init];
    detail2.title = @"订单状态:";
    detail2.content = @"";
    
    OrderDetailModel *detail3 = [[OrderDetailModel alloc] init];
    detail3.title = @"手机号:";
    detail3.content = @"";
    
    OrderDetailModel *detail4 = [[OrderDetailModel alloc] init];
    detail4.title = @"付款方式:";
    detail4.content = @"";
    
    OrderDetailModel *detail5 = [[OrderDetailModel alloc] init];
    detail5.title = @"付款时间:";
    detail5.content = @"";
    
    OrderDetailModel *detail6 = [[OrderDetailModel alloc] init];
    detail6.title = @"有效期至:";
    detail6.content = @"";
    
    OrderDetailModel *detail7 = [[OrderDetailModel alloc] init];
    detail7.title = @"总价:";
    detail7.content = @"";
    
    self.orderDetailDataSource = [[NSMutableArray alloc] initWithObjects:detail1,detail2,detail3,detail4,detail5,detail6,detail7, nil];
    
    self.shopName = @"";
    self.address = @"";
    self.telephone = @"";
    self.distance = @"- -";
}

-(void)_loadTitleView{
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;

//    [Util setTitleViewWithTitle:@"订单详情" andNav:self.navigationController];
    self.title = @"订单详情";
}

#pragma mark- 导航返回
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark- 返回到首页
-(void)goRoot
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSString *)getOrderState:(NSInteger)orderState type:(NSInteger)type
{
    NSString *resultOrderState = @"";

    if (type == 0) {
        
        //状态|默认为0，使用后为1，过期为-1，审核中为3，审核通过为5，审核不通过为6，退款完成为7
        switch (orderState) {
            case 0:
                resultOrderState = @"订单取消";
                break;
            case 10:
                resultOrderState = @"待付款";
                break;
            case 20:
                resultOrderState = @"已付款";
                break;
            case 30:
                resultOrderState = @"买家已使用";
                break;
            case 50:
                resultOrderState = @"买家评价完毕";
                break;
            case 60:
                resultOrderState = @"已完成";
                break;
            case 65:
                resultOrderState = @"订单不可评价";
                break;
            default:
                break;
        }
    } else {
        
        // 默认为0，使用后为1，过期为-1，审核中为3，审核通过为5，审核不通过为6，退款完成为7
        switch (orderState) {
            case 0:
                resultOrderState = @"未消费";
                break;
            case 1:
                resultOrderState = @"已消费";
                break;
            case -1:
                resultOrderState = @"已过期";
                break;
            case 3:
                resultOrderState = @"审核中";
                break;
            case 5:
                resultOrderState = @"审核通过";
                break;
            case 6:
                resultOrderState = @"审核不通过";
                break;
            case 7:
                resultOrderState = @"退款完成";
                break;
            default:
                break;
        }
    }
    
    return resultOrderState;
}



#pragma mark - UItableViewCell 赋值

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    //这里把数据设置给Cell
    OrderDetailDynamicCell *basicCell = (OrderDetailDynamicCell *)cell;
    NSDictionary *contentDic = self.serviceListDataSource[indexPath.row];
    [basicCell.shopImg sd_setImageWithURL:[NSURL URLWithString:contentDic[@"groupAccPath"]] placeholderImage:IMAGE(@"logoeee")];
    
    
    if (contentDic[@"groupName"]) {
        basicCell.shopName.text = [NSString stringWithFormat:@"%@",contentDic[@"groupName"]];
    }
    if (contentDic[@"totalPrice"]) {
        NSNumber *totalPrice = contentDic[@"totalPrice"];
        basicCell.price.text = [NSString stringWithFormat:@"%.2f",totalPrice.floatValue];
    }
    [basicCell.refundBtn setTitle:@"退款" forState:UIControlStateNormal];
    if (contentDic[@"groupSn"]) {
        basicCell.consumeCode.text = [NSString stringWithFormat:@"消费码:%@",contentDic[@"groupSn"]];
    }
    basicCell.consumeState.text = [self getOrderState:[contentDic[@"status"] integerValue] type:1];
    
    if ([contentDic[@"status"] integerValue] == 0) {
        basicCell.refundBtn.hidden = NO;
    } else {
//        [basicCell.refundBtn setEnabled:NO];
        basicCell.refundBtn.hidden = YES;
    }
    
    __unsafe_unretained OrderDetailDynamicCell *newCell = basicCell;
    WEAK_SELF
    
    basicCell.refundBlk = ^ {
        weak_self.groupSn = [NSString stringWithFormat:@"%@",contentDic[@"groupSn"]];
        weak_self.consumeState = newCell.consumeState;
        weak_self.refundBtn = newCell.refundBtn;

        UIAlertView *logOutAlert = [[UIAlertView alloc] initWithTitle:@"确定退款？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        logOutAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [logOutAlert show];
        [weak_self.view addSubview:logOutAlert];
    };
}

- (void)resetDataSource:(NSDictionary *)orderDetails {
    
    OrderDetailModel *detail1 = [[OrderDetailModel alloc] init];
    detail1.title = @"订单编号:";
    if(orderDetails[@"orderId"]) {
        detail1.content = [NSString stringWithFormat:@"%@",orderDetails[@"orderId"]];
    } else {
        detail1.content = @"";
    }
    OrderDetailModel *detail2 = [[OrderDetailModel alloc] init];
    detail2.title = @"订单状态:";
    if (orderDetails[@"orderStatus"]) {
        detail2.content = [self getOrderState:[orderDetails[@"orderStatus"] integerValue] type:0];
    } else {
        detail2.content = @"";
    }
    /*
     ➢	订单中如有有未消费的劵，该订单状态就是未消费状态；
     ➢	订单中所有劵都已消费，或者除了已退款的劵之外所有的劵都已消费，该订单状态就是已消费；
     ➢	订单中所有的劵都已退款，订单状态就是未消费；
     */
    
    OrderDetailModel *detail3 = [[OrderDetailModel alloc] init];
    detail3.title = @"手机号:";
    if (orderDetails[@"mobile"]) {
        detail3.content = [NSString stringWithFormat:@"%@",orderDetails[@"mobile"]];
    } else {
        detail3.content = @"";
    }
    
    OrderDetailModel *detail4 = [[OrderDetailModel alloc] init];
    detail4.title = @"付款方式:";
    if (orderDetails[@"paymentMark"]) {
        detail4.content = [NSString stringWithFormat:@"%@",orderDetails[@"paymentMark"]];
        if ([detail4.content isEqualToString:@"wxqrpay"]) {
            detail4.content = @"微信支付";
        }
        
    } else {
        detail4.content = @"";
    }
    
    OrderDetailModel *detail5 = [[OrderDetailModel alloc] init];
    detail5.title = @"付款时间:";
    if (orderDetails[@"payTime"]) {
        detail5.content = [NSString stringWithFormat:@"%@",orderDetails[@"payTime"]];
    } else {
        detail5.content = @"";
    }
    
    OrderDetailModel *detail6 = [[OrderDetailModel alloc] init];
    detail6.title = @"有效期至:";
    if (orderDetails[@"endTime"]) {
        detail6.content = [NSString stringWithFormat:@"%@",orderDetails[@"endTime"]];
    } else {
        detail6.content = @"";
    }
    
    OrderDetailModel *detail7 = [[OrderDetailModel alloc] init];
    detail7.title = @"总价:";
    if (orderDetails[@"totalPrice"]) {
        NSNumber *totalPrice = orderDetails[@"totalPrice"];
        detail7.content = [NSString stringWithFormat:@"￥%.2f",totalPrice.floatValue];
    } else {
        detail7.content = @"";
    }
    
    self.orderDetailDataSource = [[NSMutableArray alloc] initWithObjects:detail1,detail2,detail3,detail4,detail5,detail6,detail7, nil];
    
    if (orderDetails[@"storeName"]) {
        self.shopName = [NSString stringWithFormat:@"%@",orderDetails[@"storeName"]];
    } else {
        self.shopName = @"";
    }
    if (orderDetails[@"storeAddress"]) {
        self.address = [NSString stringWithFormat:@"%@",orderDetails[@"storeAddress"]];
    } else {
        self.address = @"";
    }
    if (orderDetails[@"mobile"]) {
        self.telephone = [NSString stringWithFormat:@"%@",orderDetails[@"mobile"]];
    } else {
        self.telephone = @"";
    }
    
    self.distance =[Util transferDistanceStrWithDistance:[NSNumber numberWithDouble:[orderDetails[@"distance"] doubleValue]]];
    
    NSMutableArray *serviceList = (NSMutableArray *)orderDetails[@"serviceList"];
    
    
    
    if (orderDetails[@"serviceList"] && serviceList.count > 0) {
        self.serviceListDataSource = (NSMutableArray *)orderDetails[@"serviceList"];
        self.orderType = 0;
    } else {
        self.orderType = 1;
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.serviceListDataSource.count;
    } else if (section == 1) {
        return self.orderDetailDataSource.count;
    } else if (section == 2){
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)accodingOrderStatusCalculateHeight:(NSInteger)orderStatus {
    if (orderStatus == 10) {
        if (self.status == 20) {
            return 171;
        }else if(self.status == 30) {
            return 90;
        }else {
            return 130;
        }
        
    }else{
        if (self.status == 20) {
            return 131;
        }else {
            return 90;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        NSLog(@"count -- %ld",self.serviceListDataSource.count);
        if (!self.serviceListDataSource.count) {
            return 0;
        }else {
            return [self accodingOrderStatusCalculateHeight:[self.pOrderDetail.orderStatus integerValue]];
        }
    } else if(section == 1) {
        return 54;
    } else if(section == 2) {
        return 54;
    } else {
        return 0.1;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        
        if (!self.serviceListDataSource.count) {
            return nil;
        }
            
        JGOrderDetailHeaderView *headerView = [[JGOrderDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 185)];
        [headerView stControlWidgetWithStatus:self.status];
        headerView.backgroundColor = VCBackgroundColor;
        self.headrView = headerView;
        WEAK_SELF;
        headerView.tapintoServiceDetailBlock = ^{
            if (self.serviceListDataSource.count >= 1) {
                ServiceDetailController *serviceDetailVC = [[ServiceDetailController alloc] init];
                JGOrderDetailModel *model = [[JGOrderDetailModel alloc] initWithDict:self.serviceListDataSource[0]];
                serviceDetailVC.serviceID = @(model.groudId.integerValue);
                [weak_self.navigationController pushViewController:serviceDetailVC animated:YES];
            }
        };
        self.headrView.orderDetail = self.pOrderDetail;
        return headerView;
    } if(section == 1) {
        return [[OrderDetailHeader alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 55) title:@"订单详情"];
    } if(section == 2) {
        return [[OrderDetailHeader alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 55) title:@"地址信息"];
    } else {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"JGOrderDtailCell";
        JGOrderDtailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[JGOrderDtailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        if (self.serviceListDataSource.count) {
            JGOrderDetailModel *model = [[JGOrderDetailModel alloc] initWithDict:self.serviceListDataSource[indexPath.row]];
            cell.detailModel = model;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        static NSString *OrderDetailDynamicCellIdentifier = @"OrderDetailDynamicCellIdentifier";
//        
//        OrderDetailDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailDynamicCellIdentifier];
//        if (cell == nil) {
//            cell = [[OrderDetailDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailDynamicCellIdentifier];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        
//        [self loadCellContent:cell indexPath:indexPath];
//
//        cell.backgroundColor = [UIColor redColor];
//        
//        NSDictionary *contentDic = self.serviceListDataSource[indexPath.row];
//        
//        JGLog(@"%@",contentDic);
//        JGLog(@"%@", self.serviceListDataSource);
//
//        UIWebView *qrcodeWeb = [[UIWebView alloc] init];
//        qrcodeWeb.backgroundColor = [UIColor redColor];
//        qrcodeWeb.scrollView.scrollEnabled = NO;
//        qrcodeWeb.x = (ScreenWidth - 240) / 2;
//        qrcodeWeb.y = 172;
//        qrcodeWeb.width = 240;
//        qrcodeWeb.delegate = self;
//        qrcodeWeb.height = 240;
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://static.jgyes.cn/static/app/yqfx.html#%@",TNSString(contentDic[@"groupSn"])]];
//        [qrcodeWeb loadRequest:[NSURLRequest requestWithURL:url]];
//        [cell.contentView addSubview:qrcodeWeb];
        return cell;

    } else if(indexPath.section == 1) {
        static NSString *OrderDetailCellIdentifier = @"OrderDetailCellIdentifier";
        
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailCellIdentifier];
        if (cell == nil) {
            cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        OrderDetailModel *model = [self.orderDetailDataSource objectAtIndex:indexPath.row];
        cell.title.text = model.title;
        cell.content.text = model.content;
        
        return cell;
    } else if(indexPath.section == 2) {
        static NSString *OrderDetailAddressCellIdentifier = @"OrderDetailAddressCellIdentifier";
        
        OrderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailAddressCellIdentifier];
        if (cell == nil) {
            cell = [[OrderDetailAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailAddressCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.shopName.text = self.shopName;
        cell.address.text = self.address;
        cell.distance.text = self.distance;
        
        WEAK_SELF
        cell.phoneCallBlk = ^{
            if (weak_self.telephone.length > 0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", weak_self.telephone]]];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"商家手机号为空!"
                                                                   delegate:nil
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"确认", nil];
                [alertView show];
            }
        };
        
        return cell;
    } else {
        return [UITableViewCell new];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 54 ;
    } else if (indexPath.section == 1) {
        return 45;
    } else if (indexPath.section == 2) {
        return 68;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        JGDropdownMenu *menu = [JGDropdownMenu menu];
        [menu configTouchViewDidDismissController:YES];
        [menu configBgShowMengban];
        UIViewController *activityController = [[UIViewController alloc] init] ;
        
        NSDictionary *contentDic = self.serviceListDataSource[indexPath.row];
        NSString *status = TNSString( contentDic[@"status"]);
        if ([status isEqualToString:@"1"]) {
            return;
        }
        
        JGLog(@"%@",contentDic);
        JGLog(@"%@", self.serviceListDataSource);

        UIWebView *qrcodeWeb = [[UIWebView alloc] init];
        qrcodeWeb.backgroundColor = [UIColor clearColor];
        qrcodeWeb.scrollView.scrollEnabled = NO;
        qrcodeWeb.x = (ScreenWidth - 240) / 2;
        qrcodeWeb.y = 0;
        qrcodeWeb.width = 240;
        qrcodeWeb.delegate = self;
        qrcodeWeb.height = 240;
    
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kProCheckConsumeLink,[self configQRCodeParams]]];
        // http://shop.jgyes.com/mobile_register.htm?invitationCode=life59520151228144151-8210571571-6
        
        [qrcodeWeb loadRequest:[NSURLRequest requestWithURL:url]];
        [activityController.view addSubview:qrcodeWeb];
        activityController.view.backgroundColor = [UIColor clearColor];
        activityController.view.width = ScreenWidth;
        activityController.view.height = 240;
        menu.contentController = activityController;
        [menu showWithFrameWithDuration:0.25];
        
//        NSDictionary *contentDic = self.serviceListDataSource[indexPath.row];
//        ServiceDetailController *serviceDetailVC = [[ServiceDetailController alloc] init];
//        serviceDetailVC.serviceID = [NSNumber numberWithInteger:[contentDic[@"groupId"] integerValue]];
//        [self.navigationController pushViewController:serviceDetailVC animated:YES];
        
    } else if (indexPath.section == 2) {
        XKJHMapViewController *mapVC = [[XKJHMapViewController alloc] init];
        mapVC.shopAddress = self.address;
        mapVC.latitude = [self.pOrderDetail.storeLat floatValue];
        mapVC.longitude = [self.pOrderDetail.storeLon floatValue];
        [self.navigationController pushViewController:mapVC animated:YES];
    }
}

- (NSString *)configQRCodeParams {
    NSString *configParams = [NSString stringWithFormat:@"%ld",self.orderId];
//    JGOrderDetailModel *model = [[JGOrderDetailModel alloc] initWithDict:self.serviceListDataSource[indexPath.row]];
//    NSString *status = model.status;
//    configParams = [configParams stringByAppendingString:status];
    
//    configParams = [configParams stringByAppendingString:[NSString stringWithFormat:@""]];
//    for (NSDictionary * dic in self.serviceListDataSource) {
//        if ([TNSString(dic[@"status"]) integerValue] == 0) {
//            configParams = [configParams stringByAppendingString:[NSString stringWithFormat:@",%@",TNSString(dic[@"groupSn"])]];
//        }
//    }
    return configParams;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.serviceListDataSource.count) {
            NSDictionary *detailDic = self.serviceListDataSource[indexPath.row];
            if ([TNSString(detailDic[@"status"]) isEqualToString:@"0"]) {
                return YES;
            }else {
                return NO;
            }
        }
        return NO;
    }else
        return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.response) {
        ApplySalesReturnVC *vc = [[ApplySalesReturnVC alloc] initWithResponse:self.response];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"退款";
}



#pragma mark - alert delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {//确定
        UITextField *textField = [alertView textFieldAtIndex:0];
        if(textField.text &&![textField.text  isEqual: @""]){
//            [self _requestOrderRefund:textField.text];
            // 周边服务-线上服务订单-订单详情退款
            
            if (self.response) {
                ApplySalesReturnVC *vc = [[ApplySalesReturnVC alloc] initWithResponse:self.response];
                [self.navigationController pushViewController:vc animated:YES];
            }
           
        }
        else{
           UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:@"请填写退款原因" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];
        }
    }
}

#pragma mark - 接口请求

#pragma mark - 个人订单详情接口
-(void)_requestPersonalOrderDetails{
    
    PersonalOrderDetailsRequest *request = [[PersonalOrderDetailsRequest alloc] init:GetToken];
    
    request.api_orderId = [NSNumber numberWithInteger:self.orderId];
    request.api_storeLat = [[mapObject sharedMap] baiduLatitude];
    request.api_storeLon = [[mapObject sharedMap] baiduLongitude];
    
    WeakSelf;
    [self.vapManager personalOrderDetails:request success:^(AFHTTPRequestOperation *operation, PersonalOrderDetailsResponse *response) {
        JGLog(@"\n");
        JGLog(@"res:%@",response);
        JGLog(@"\n");
        StrongSelf;
        strongSelf.pOrderDetail = [POrderDetails objectWithKeyValues:response.orderDetails];
        strongSelf.response = response;
        [strongSelf resetDataSource:(NSDictionary *)response.orderDetails];
        [strongSelf.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
}





#pragma mark - 退款
-(void)_requestOrderRefund:(NSString *)api_refund{
    NSString *api_groupSn;

    if (self.serviceListDataSource.count) {
        NSDictionary *orderIndexDict = self.serviceListDataSource[self.refundIndexPath.row];
        api_groupSn = TNSString(orderIndexDict[@"groupSn"]);
    }
    PersonalCouponRefundRequest *request = [[PersonalCouponRefundRequest alloc] init:GetToken];
    request.api_groupSn = api_groupSn;
    request.api_refundReasion = api_refund;
    
    WEAK_SELF
    [self.vapManager personalCouponRefund:request success:^(AFHTTPRequestOperation *operation, PersonalCouponRefundResponse *response) {
        if (IsEmpty(response.subCode)) {
            weak_self.consumeState.text = @"退款中";
            weak_self.refundBtn.hidden = YES;
            [weak_self _requestPersonalOrderDetails];
        } else {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
            hub.labelText = @"退款失败";
            [hub hide:YES afterDelay:1.5];
            [weak_self _requestPersonalOrderDetails];

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_self.view animated:YES];
        hub.labelText = @"退款失败";
        [hub hide:YES afterDelay:1.5];
        [weak_self _requestPersonalOrderDetails];

    }];
}

@end
