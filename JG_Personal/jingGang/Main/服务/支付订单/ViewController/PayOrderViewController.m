//
//  PayOrderViewController.m
//  jingGang
//
//  Created by thinker on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "PayOrderViewController.h"
#import "Masonry.h"
#import "PublicInfo.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "PayOrderTableViewCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "GlobeObject.h"
#import "WXPayRequestModel.h"
#import "VApiManager.h"
#import "GloableEmerator.h"
#import "AppDelegate.h"
#import "PayYunBiTableViewCell.h"
#import "WSProgressHUD.h"
#import "OrderDetailController.h"
#import "KJShoppingAlertView.h"
#import "APIManager.h"
#import "Util.h"
#import "KJOrderStatusQuery.h"
#import "IQKeyboardManager.h"
#import "OrderConfirmViewController.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "ShoppingOrderDetailController.h"
#import "IntegralResultViewController.h"
#import "IntegralDetailViewController.h"
#import <ReactiveCocoa.h>
#import "Util.h"
#import "ChangYunbiPasswordViewController.h"
@interface PayOrderViewController () <UITableViewDelegate,UITableViewDataSource,APIManagerDelegate,UIAlertViewDelegate>{
    
    VApiManager *_vapManager;
    NSTimer     *_orderStatusQueryTimer;//订单状态轮询计时器
    NSInteger   _orderStatusQueryCount; //订单状态轮询计数器
    KJOrderStatusQuery *_orderStatusQuery;//订单状态查询类
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) UIView *footView;

@property (nonatomic) NSArray *dataSource;
@property (nonatomic) NSArray *orderHeadData;
@property (nonatomic, weak) UIButton *selectedBtn;

@property (nonatomic) BOOL showPassword;

@property (nonatomic) BOOL hasSetYunbiPasswd;
@property (nonatomic) BOOL isGotoSetYunbiPasswd;
@property (nonatomic, strong)UIButton *lastButton;

@property (nonatomic) NSString *passoword;

@property (nonatomic) APIManager *yunbiManager;
@property (nonatomic) APIManager *paymetManager;

@end


@implementation PayOrderViewController

static NSString *cellIdentifier = @"PayOrderTableViewCell";
static NSString *cellid = @"TiteOnlyCell";
static NSString *yunbiIdentifier = @"PayYunBiTableViewCell";

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    
    NSLog(@"order id %lld",self.orderID.longLongValue);
    _vapManager = [[VApiManager alloc] init];
    _orderStatusQueryCount = 0;
    //测试支付
    //    [self _PayWithType:WxPayType];
    
    [self setUIContent];
    [self setViewsMASConstraint];
    self.yunbiManager = [[APIManager alloc] initWithDelegate:self];
    [self.yunbiManager getUsersIntegral];
    self.paymetManager = [[APIManager alloc] initWithDelegate:self];
    [self.paymetManager getPaymentView:self.orderID.longValue];
}

- (void)viewWillAppear:(BOOL)animated {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animate {
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1003 && buttonIndex == 1) {
        [self _commintoOrderDetail];
    }
}


#pragma mark - UITableViewDelegate
//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self tableHeaderView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)getHeightTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 45.5;
    } else if (indexPath.section == 1) {
        return [tableView fd_heightForCellWithIdentifier:yunbiIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
            [self loadCellContent:cell indexPath:indexPath];
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
            [self loadCellContent:cell indexPath:indexPath];
            
        }];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightTableView:tableView atIndexPath:indexPath];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 1;
    }
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        }
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:yunbiIdentifier];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    [self loadCellContent:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    //这里把数据设置给Cell
    if (indexPath.section == 0) {
        cell.textLabel.attributedText = self.orderHeadData[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    } else if (indexPath.section == 1) {
        PayYunBiTableViewCell *yunbiCell = (PayYunBiTableViewCell *)cell;
        yunbiCell.whetherSetYunbiPasswd = self.hasSetYunbiPasswd;
        [yunbiCell setYunbi:self.userMoneyPaymet totalPrice:self.totalPrice];
        [RACObserve(self, showPassword) subscribeNext:^(NSNumber *show) {
            [yunbiCell needShowPassword:show.boolValue];
        }];
        if (yunbiCell.showPasswordBlock == nil) {
            yunbiCell.showPasswordBlock = ^(BOOL isSelected,UIButton *selecBtn) {
                self.showPassword = isSelected;
                if (self.totalPrice < self.userMoneyPaymet && isSelected) {
                    self.selectedBtn.selected = NO;
                }
                if (self.showPassword && !self.hasSetYunbiPasswd) {//展开了，但是没有设置云币密码
                    self.isGotoSetYunbiPasswd = YES;
                }else {
                    self.isGotoSetYunbiPasswd = NO;
                }
                [self.tableView reloadData];
            };
        }
    } else {
        NSArray *data = self.dataSource[indexPath.row];
        PayOrderTableViewCell *payOrderCell = (PayOrderTableViewCell *)cell;
        payOrderCell.payImage.image = [UIImage imageNamed:data[0]];
        payOrderCell.payTitle.text = data[1];
        payOrderCell.payInform.text = data[2];
        payOrderCell.selectBtn.tag = indexPath.row;
        if (payOrderCell.selectPayBlock == nil) {
            payOrderCell.selectPayBlock = ^(UIButton *selecBtn) {
                self.selectedBtn = selecBtn;
                if (self.totalPrice < self.userMoneyPaymet && selecBtn.isSelected) {
                    self.showPassword = NO;
                }
                [self.tableView reloadData];
            };
        }
    }
    
}


#pragma mark - APIManagerDelegate 处理网络请求
- (void)apiManagerDidSuccess:(APIManager *)manager {
    if (manager == self.yunbiManager) {
        UsersIntegralResponse *response = (UsersIntegralResponse *)manager.successResponse;
        if (response.availableBalance != nil) {
            self.userMoneyPaymet = response.availableBalance.doubleValue;
            self.hasSetYunbiPasswd = response.isCloudPassword.integerValue;
            [self.tableView reloadData];
        }
    } else if (manager == self.paymetManager) {
        ShopTradePaymetViewResponse *response = manager.successResponse;
        if (self.jingGangPay == ShoppingPay) {
            self.totalPrice = response.totalPrice.doubleValue;
        }
        [self.tableView reloadData];
    }
}


- (void)apiManagerDidFail:(APIManager *)manager {
    if (-1009 == [[manager error] code]) {
        NSLog(@"网络连接断开");
    }
}



#pragma mark - event response

- (void)backToGouwu
{
    /*NSArray *allVC = self.navigationController.viewControllers;
     UIViewController *VC = allVC[allVC.count-2];
     if ([VC isKindOfClass:[OrderConfirmViewController class]]) {
     [self.navigationController popToViewController:allVC[allVC.count-3] animated:YES];
     } else {
     [self.navigationController popViewControllerAnimated:YES];
     }*/
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否放弃支付?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alert.tag = 1003;
    [alert show];
    
}

-(void)_gotoSetYunbiPasswdPage {
    //去设置云币密码
    ChangYunbiPasswordViewController *changeYunbiPasswdVC = [[ChangYunbiPasswordViewController alloc] init];
    changeYunbiPasswdVC.isComfromPayPage = YES;
    WEAK_SELF
    changeYunbiPasswdVC.changeYunbiPasswdSuccess= ^{
        weak_self.isGotoSetYunbiPasswd = NO;
        weak_self.hasSetYunbiPasswd = YES;
        [weak_self.tableView reloadData];
    };
    [self.navigationController pushViewController:changeYunbiPasswdVC animated:YES];
}

- (void)commitOrderAction {
    
    if (self.isGotoSetYunbiPasswd) {
        [self _gotoSetYunbiPasswdPage];
        return;
    }
    
    PayYunBiTableViewCell *yunbiCell = (PayYunBiTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    self.passoword = yunbiCell.password;
    if (self.passoword.length && self.showPassword) {//只要云币密码输了，就一定会有云币支付
        if (self.selectedBtn.selected) {//选择了下面的第三方支付,复合支付
            if (self.selectedBtn.tag == 0) {//云币+微信
                [self _PayWithType:WxPayType withMoneyPay:YES];
            }else if (self.selectedBtn.tag == 1){//云币+支付宝
                [self _PayWithType:AliPayType withMoneyPay:YES];
            }
        }else {//只是云币支付
            if (self.userMoneyPaymet < self.totalPrice) {
                [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"云币不足,请选择其他支付方式"];
                return;
            }else {
                [self _payUsingMoneyPay];
            }
        }
    }else {//否则一定没有，
        if (self.selectedBtn.selected) {//选择了下面的第三方支付，只是单独第三支付
            if (self.selectedBtn.tag == 0) {//微信
                [self _PayWithType:WxPayType withMoneyPay:NO];
            }else if (self.selectedBtn.tag == 1){//支付宝
                [self _PayWithType:AliPayType withMoneyPay:NO];
            }
        }else{//什么支付都没选
            NSString *alertTitle = @"";
            alertTitle = self.showPassword ? @"请输入云币密码":@"你还没有选择支方式，请选择支付方式";
            [Util ShowAlertWithOutCancelWithTitle:@"提示" message:alertTitle];
            return;
        }
    }
    
    
}

#pragma mark - private methods

- (void)showPasswordError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您的云币支付密码错误" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (NSAttributedString *)getAttributeString:(NSString *)orignStr atIndex:(NSInteger)index {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:orignStr];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:13.0],NSFontAttributeName,
                                   [UIColor lightGrayColor],NSForegroundColorAttributeName,nil
                                   ];
    NSRange range = [attributedString.string rangeOfString:@":"];
    range = NSMakeRange(0, range.location+1);
    [attributedString addAttributes:attributeDict range:range];
    
    if (index == 3) {
        NSDictionary *attributeDict2 = [ NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:13.0],NSFontAttributeName,
                                        status_color,NSForegroundColorAttributeName,nil
                                        ];
        range = NSMakeRange(range.location+range.length, attributedString.length - (range.location+range.length));
        [attributedString addAttributes:attributeDict2 range:range];
    }
    
    return attributedString.copy;
}


- (void)initTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 45.5;
    self.tableView.rowHeight = 45.5;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
    nibCell = [UINib nibWithNibName:yunbiIdentifier bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:yunbiIdentifier];
    
    [self.tableView setTableFooterView:self.footView];
}

- (void)setBarButtonItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(backToGouwu) target:self];
}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)setUIContent {
    [self setNavigationBar];
    [self setBarButtonItem];
    [self initTableView];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"支付订单";
}

- (void)setViewsMASConstraint {
    UIView *superView = self.view;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(-1);
        make.left.equalTo(superView);
        make.bottom.equalTo(superView);
        make.right.equalTo(superView);
    }];
}

#pragma mark - getters and settters

- (void)setSelectedBtn:(UIButton *)selectedBtn {
    if (_selectedBtn == selectedBtn) {
        
        //        selectedBtn.selected = !selectedBtn.selected;
    } else {
        [_selectedBtn setSelected:NO];
        [selectedBtn setSelected:YES];
        _selectedBtn = selectedBtn;
    }
}

-(void)setIsGotoSetYunbiPasswd:(BOOL)isGotoSetYunbiPasswd {
    _isGotoSetYunbiPasswd = isGotoSetYunbiPasswd;
    if (_isGotoSetYunbiPasswd) {
        [self.lastButton setTitle:@"设置云币密码" forState:UIControlStateNormal];
    }else {
        [self.lastButton setTitle:@"确认付款" forState:UIControlStateNormal];
    }
}

- (NSArray *)orderHeadData {
    _orderHeadData = @[
                       [self getAttributeString:[NSString stringWithFormat:@"订单编号: %@",self.orderNumber] atIndex:1],
                       [self getAttributeString:[NSString stringWithFormat:@"订单金额: %.2f元",self.totalPrice ] atIndex:2],
                       ];
    
    return _orderHeadData;
}

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        //        NSArray *first = @[@"bandcards-6+",@"银行卡支付",@"支付储蓄信用卡,无需开通网银"];
        NSArray *second = @[@"wechatapy",@"微信支付",@"推荐安装微信5.0及以上的版本使用"];
        NSArray *third = @[@"zhifubaopay",@"支付宝支付",@"推荐已安装支付宝的用户使用"];
        _dataSource = @[
                        second,
                        third,
                        ];
    }
    
    return _dataSource;
}

- (UIView *)lineView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    return lineView;
}

- (UIView *)tableHeaderView {
    CGFloat onePXHeight = 1/[UIScreen mainScreen].scale;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 10+2*onePXHeight)];;
    headView.backgroundColor = [UIColor clearColor];
    UIView *headlineView = [self lineView];
    [headView addSubview:headlineView];
    [headlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView);
        make.right.equalTo(headView);
        make.top.equalTo(headView);
        make.height.equalTo(@(onePXHeight));
    }];
    UIView *footlineView = [self lineView];
    [headView addSubview:footlineView];
    [footlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView);
        make.right.equalTo(headView);
        make.bottom.equalTo(headView);
        make.height.equalTo(@(onePXHeight));
    }];
    
    return headView;
}

- (UIView *)footView {
    if (_footView == nil) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, 84)];
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = status_color;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"确认付款" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(commitOrderAction) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 5.0;
        self.lastButton = button;
        [_footView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_footView);
            make.height.equalTo(@44);
            make.left.equalTo(_footView).with.offset(12);
            make.right.equalTo(_footView).with.offset(-12);
        }];
        _footView.backgroundColor = [UIColor clearColor];
    }
    
    return _footView;
}


#pragma mark ------------------------ Pay ------------------------
-(void)_PayWithType:(PayType)payType withMoneyPay:(BOOL)moneyPay{
    
    //初始化订单查询类,在请求支付时创建
    _orderStatusQuery = [[KJOrderStatusQuery alloc] initWithQueryOrderID:self.orderID];
    [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeBlack];
    ShopTradePaymetRequest *request = [[ShopTradePaymetRequest alloc] init:GetToken];
    request.api_mainOrderId = @([self.orderID integerValue]);
    request.api_paymentType = (payType == WxPayType) ? WXPay:AliPay;
    request.api_isUserMoneyPaymet = @(moneyPay);
    if (moneyPay) {
        request.api_paymetPassword = self.passoword;
    }
    //商城，O2O支付
    if (self.jingGangPay == ShoppingPay) {
        request.api_type = @1;
    } else if (self.jingGangPay == O2OPay) {
        request.api_type = @2;
        //标志服务订单，支付完成查询
        _orderStatusQuery.isServiceOrderQuery = YES;
    } else if (self.jingGangPay == IntegralPay) {
        //标志积分订单，支付完成查询
        _orderStatusQuery.isIntegralGoodsOrderQuery = YES;
        request.api_type = @3;
    }
    AppDelegate *appDelegat = kAppDelegate;
    appDelegat.payCommepletedTransitionNav = self.navigationController;
    appDelegat.orderID = self.orderID;
    appDelegat.jingGangPay = self.jingGangPay;
    [_vapManager shopTradePaymet:request success:^(AFHTTPRequestOperation *operation, ShopTradePaymetResponse *response) {
        NSLog(@"支付请求网络 -- %@ ",response);
        [WSProgressHUD dismissAfterSeconds:0.5];
        if (response.errorCode.integerValue > 0) {
            [Util ShowAlertWithOnlyMessage:response.subMsg];
        }else{
            if ([response.paymetType isEqualToString:@"wx_app"]) {//微信
                [self _wxPayWithParamDic:(NSDictionary *)response.weiXinPaymet];
            }else{
                [self _alipayTestWithSignedStr:response.paySignature];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@" error %@",error);
        [WSProgressHUD dismissAfterSeconds:0.5];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        
    }];
}

#pragma mark - 采用云币支付 - 和支付宝，微信支付独立开来
-(void)_payUsingMoneyPay{
    
    [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeBlack];
    ShopTradePaymetRequest *request = [[ShopTradePaymetRequest alloc] init:GetToken];
    request.api_mainOrderId = @([self.orderID integerValue]);
    request.api_isUserMoneyPaymet = @1;
    request.api_paymetPassword = self.passoword;
    //商城，O2O支付
    if (self.jingGangPay == ShoppingPay) {
        request.api_type = @1;
    }else if(self.jingGangPay == O2OPay){
        request.api_type = @2;
    }else if (self.jingGangPay == IntegralPay){
        request.api_type = @3;
    }
    [_vapManager shopTradePaymet:request success:^(AFHTTPRequestOperation *operation, ShopTradePaymetResponse *response) {
        [WSProgressHUD dismiss];
        if (response.errorCode.integerValue > 0) {
            if ([response.subCode isEqualToString:@"payment_passwor_not_exist"]) {
                //用户没有设置云币支付密码，跳转
            }
            [Util ShowAlertWithOnlyMessage:response.subMsg];
        }else{
            [KJShoppingAlertView showAlertTitle:@"云币支付成功" inContentView:self.view];
            //进入订单详情页
            [self performSelector:@selector(_commintoOrderDetail) withObject:nil afterDelay:2.0];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@" error %@",error);
        [WSProgressHUD dismiss];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        //        [self performSelector:@selector(_commintoOrderDetail) withObject:nil afterDelay:2.0];
    }];
    
}
#pragma mark - 进入订单详情
-(void)_commintoOrderDetail{
    
    switch (self.jingGangPay) {
        case ShoppingPay:
        {
            OrderDetailController *orderDetailVC = [[OrderDetailController alloc] init];
            orderDetailVC.orderID = self.orderID;
            [self.navigationController pushViewController:orderDetailVC animated:YES];
        }
            break;
        case O2OPay:
        {
            ShoppingOrderDetailController *serviceOrderDetailVC = [[ShoppingOrderDetailController alloc] init];
            serviceOrderDetailVC.orderId = self.orderID.integerValue;
            serviceOrderDetailVC.controllerType = ControllerServicePayType;
            [self.navigationController pushViewController:serviceOrderDetailVC animated:YES];
        }
            break;
        case IntegralPay:
        {
            IntegralDetailViewController *vc = [[IntegralDetailViewController alloc] init];
            vc.orderId = self.orderID;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 支付宝支付
-(void)_alipayTestWithSignedStr:(NSString *)signedStr{
    
    [[AlipaySDK defaultService] payOrder:signedStr fromScheme:@"jingGangAlipay" callback:^(NSDictionary *resultDic) {
        NSLog(@"支付宝 reslut = %@",resultDic);
        NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];
        if (resultStatus == 9000) {//支付宝支付成功查询服务器
            //查询服务器订单状态
            [WSProgressHUD showShimmeringString:@"正在查询订单状态.." maskType:WSProgressHUDMaskTypeBlack];
            //开启订单查询
            [_orderStatusQuery beginRollingQueryWithIntervalTime:2.0 rollingResult:^(BOOL success) {
                [self _queryDealResult:success];
            }];
        }else{//支付宝支付失败
            NSString *alertErrorStr = @"支付失败";
            switch (resultStatus) {
                case 8000:
                    alertErrorStr = @"支付宝订单正在处理中";
                    break;
                case 4000:
                    alertErrorStr = @"订单支付失败";
                    break;
                case 6002:
                    alertErrorStr = @"网络连接出错，支付失败";
                    break;
                default:
                    break;
            }
            if (resultStatus != 6001 ) {//取消
                [Util ShowAlertWithOnlyMessage:alertErrorStr];
                [self performSelector:@selector(_commintoOrderDetail) withObject:nil afterDelay:2.0];
            }
        }
    }];
}


#pragma mark - 轮询结果处理
-(void)_queryDealResult:(BOOL)sucess{
    
    if (sucess) {
        [WSProgressHUD dismiss];
        [KJShoppingAlertView showAlertTitle:@"支付成功" inContentView:self.view];
        //进入订单详情
        [self performSelector:@selector(_commintoOrderDetail) withObject:nil afterDelay:2.0];
    }
}


#pragma mark - 微信支付
-(void)_wxPayWithParamDic:(NSDictionary *)requestDic{
    
    //    if (![WXApi isWXAppInstalled]) {
    //        [Util ShowAlertWithOnlyMessage:@"推荐已安装微信0及以上版本的使用"];
    //        return;
    //    }
    WXPayRequestModel *model = [[WXPayRequestModel alloc] initWithJSONDic:requestDic];
    //发起微信支付，设置参数
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = model.partnerid;
    request.prepayId = model.prepayid;
    request.package = model.package1;
    request.nonceStr = model.noncestr;
    request.timeStamp = (UInt32)model.timestamp.longLongValue;
    request.sign = model.sign;
    
    //调用微信
    [WXApi sendReq:request];
    
    
}



#pragma mark - debug operation
- (void)updateOnClassInjection {
    
}


@end
