//
//  OrderConfirmViewController.m
//  jingGang
//
//  Created by thinker on 15/8/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OrderConfirmViewController.h"
#import "Masonry.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DefaultAddressTableViewCell.h"
#import "GoodsPayTableViewCell.h"
#import "IntegralTableViewCell.h"
#import "WSJManagerAddressViewController.h"
#import "ApiManager.h"
#import "ShopCenterListReformer.h"
#import "PublicInfo.h"
#import "WSJAddAddressViewController.h"
#import "ShopCenterListReformer.h"
#import "PayOrderViewController.h"
#import "ActionSheetStringPicker.h"
#import "MBProgressHUD.h"
#import "ShopManager.h"
#import "YouhuiManager.h"
#import "IQKeyboardManager.h"
#import "GoodsManager.h"

@interface OrderConfirmViewController () <UITableViewDelegate,UITableViewDataSource,APIManagerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) DefaultAddressTableViewCell *addressCell;
@property (nonatomic, weak) IntegralTableViewCell *jifengCell;
@property (nonatomic) APIManager *buyNowManager;//从立即购买进去
@property (nonatomic) APIManager *orderConfirmManager;
@property (nonatomic) APIManager *createOrder;
@property (nonatomic) APIManager *transManager;
@property (nonatomic, strong) ShopCenterListReformer <AddressReformerProtocol> *shopCenterReformer;
@property (nonatomic) NSDictionary *reformedAddressData;
@property (nonatomic) NSArray *transList;
@property (nonatomic) NSArray *couponInfoList;
@property (nonatomic) NSArray *goodsCartList;
@property (nonatomic) NSArray *shopsName;
@property (nonatomic) NSArray *shopStores;
@property (nonatomic) NSNumber *createOrderID;
@property (nonatomic) NSMutableArray *feedArray;
@property (nonatomic) NSMutableArray *transArray;
@property (nonatomic) MBProgressHUD *progressHUD;
@property (nonatomic) NSMutableArray *shopArray;

@end

@implementation OrderConfirmViewController

static NSString *cellIdentifierHead = @"DefaultAddressTableViewCell";
static NSString *cellIdentifier = @"GoodsPayTableViewCell";

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewsMASConstraint];
    [self setUIContent];
    self.transManager = [[APIManager alloc] initWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //发起网络请求获取用户的收货地址信息
    if (self.transArray == nil) {
        if (!self.isComeFromBuyNow) {//不是从立即购买进来，就是从购物车进来
            [self.orderConfirmManager confirmOrder:self.gcIds];
        }else {
            [self.buyNowManager buyNowWithGoodsId:self.goodsId goodsCount:self.goodsCount goodsGsp:self.goodsGsp];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animate {
    [super viewWillDisappear:animate];
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex == 1) {
            [self showManagerAddressVC];
        } else if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:cellIdentifierHead cacheByIndexPath:indexPath configuration:^(id cell) {
            [self loadCellContent:cell indexPath:indexPath];
            
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
            [self loadCellContent:cell indexPath:indexPath];
            
        }];
    }
}

- (CGFloat)getCellHeight:(UITableViewCell*)cell
{
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:cellIdentifierHead cacheByIndexPath:indexPath configuration:^(id cell) {
            [self loadCellContent:cell indexPath:indexPath];
            
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
            [self loadCellContent:cell indexPath:indexPath];
            
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self showManagerAddressVC];
    }
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsCartList.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierHead];
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
    if (indexPath.row == 0) {
        self.addressCell = (DefaultAddressTableViewCell *)cell;
        [self.addressCell changeAddress:self.reformedAddressData];

    } else {
        GoodsPayTableViewCell *shopCell = (GoodsPayTableViewCell *)cell;
        WEAK_SELF;
        if (shopCell.indexPath == nil) {
            shopCell.indexPath = indexPath;
            shopCell.selecYouhui = ^(NSIndexPath *indexPath) {
                [weak_self changeYouhui:indexPath];
            };
            shopCell.selecTransport = ^(NSIndexPath *indexPath) {
                [weak_self changeTransport:indexPath];
            };
            shopCell.textEditend = ^(NSIndexPath *indexPath,NSString *feedBack) {
                [weak_self setfeedBack:indexPath feedBack:feedBack];
            };
            shopCell.selectJifengBlock = ^() {
                [weak_self updateTotlaPrice];
            };
        }
        [shopCell configYouhuiList:(NSArray *)self.couponInfoList[indexPath.row-1]];
        [shopCell configShopManager:self.shopArray[indexPath.row-1]];
        [shopCell setTransport:((NSArray *)self.transList[indexPath.row-1]).firstObject];
    }
}

#pragma mark - APIManagerDelegate
- (void)apiManagerDidSuccess:(APIManager *)manager {
    if (manager == self.orderConfirmManager || manager == self.buyNowManager) {
        
        NSDictionary *orderListDic = nil;
        if (manager == self.orderConfirmManager) {
            ShopCartGoodsDetailResponse *response = manager.successResponse;
            orderListDic = ((NSDictionary *)response.orderList);
        }else {
            ShopBuyGoodsResponse *response = manager.successResponse;
            orderListDic = ((NSDictionary *)response.orderList);
        }
        
        NSArray *orderList = ((NSArray *)orderListDic[@"orderList"]);
        if (orderList == nil) {
            NSLog(@"还没有任何订单");                        
            return;
        }
//        NSDictionary *defaultAddress = [manager fetchAddressDataWithReformer:self.shopCenterReformer];
        NSDictionary *defaultAddress = [manager fetchAddressDataWithReformer:self.shopCenterReformer withOrderListDic:orderListDic];
        if (defaultAddress == nil) {
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"您还没有设置收货地址,请点击进行设置"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"确定", nil];
            alertV.tag = 1000;
            [alertV show];
            return;
        }
        self.transList = [self.shopCenterReformer getTransList:orderList];
        self.couponInfoList = [self.shopCenterReformer getCouponInfoList:orderList];
        self.goodsCartList = [self.shopCenterReformer getGoodsCartListList:orderList];
        
        if (!self.gcIds) {
            self.gcIds = [self getShopCartGoodsIdsForShopCartGoods:self.goodsCartList];
        }
        
        self.shopStores = [self.shopCenterReformer getshopStores:orderList];
        
        self.transArray = [[NSMutableArray alloc] init];
        self.feedArray = [[NSMutableArray alloc] init];
        self.shopArray = [[NSMutableArray alloc] init];
        for (NSArray *array in self.transList) {
            [self.transArray addObject:array.firstObject ];
            [self.feedArray addObject:@""];
        }
        for (int  i = 0; i < self.goodsCartList.count; i++) {
            ShopManager *shopManager = [[ShopManager alloc] initWithShopStore:self.shopStores[i]];
            [shopManager getGoodsWithGoodsCartList:self.goodsCartList[i]];
            shopManager.transportWay = self.transList[i];
            shopManager.youhuiArray = [[NSMutableArray alloc] init];
            [self.shopArray addObject:shopManager];
        }
        
        [self hiddenSubviews:NO];
        [self.tableView reloadData];
        [self changeAddress:defaultAddress];
        [self updateTotlaPrice];
    } else if (self.createOrder == manager) {
        [self.progressHUD hide:YES];
        ShopTradeOrderCreateResponse *response = manager.successResponse;
        if (response.errorCode.length > 0) {
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:response.subMsg
                                                            delegate:self
                                                   cancelButtonTitle:nil
                                                   otherButtonTitles:@"确定", nil];
            [alertV show];
        } else {
            self.createOrderID = ((NSDictionary *)response.order)[@"id"];
            PayOrderViewController *VC = [[PayOrderViewController alloc] initWithNibName:@"PayOrderViewController" bundle:nil];
            VC.jingGangPay = ShoppingPay;
            VC.orderID = self.createOrderID;
            VC.orderNumber = ((NSDictionary *)response.order)[@"orderId"];
            NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
            VC.totalPrice = [[self.totalPrice.text stringByTrimmingCharactersInSet:nonDigits] floatValue];
            [self.navigationController pushViewController:VC animated:YES];
        }
    } else if (manager == self.transManager) {
        ShopTransportGetResponse *response = manager.successResponse;
        NSArray *trans = response.trans;
        for (NSInteger i = 0;i < trans.count;i++) {
            NSDictionary *transDic = trans[i];
            if (transDic[@"trans"] == nil) {
                return;
            } else {
            
            
            }
        }
    }
    
}

- (void)apiManagerDidFail:(APIManager *)manager {
    if (-1009 == [[manager error] code]) {
        NSLog(@"网络连接断开");
        
    }
    if (self.createOrder == manager) {
        [self.progressHUD hide:YES];
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"创建订单失败"
                                                        delegate:self
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"确定", nil];
        [alertV show];
    }
}


#pragma mark - event response

- (IBAction)createOrderAction:(id)sender {
    NSNumber *addrID = self.reformedAddressData[addressKeyAddressID];
    NSMutableDictionary *transportIds = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *msgsDic = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *youhuiIds = [[NSMutableDictionary alloc] init];
    NSString *integralIds = @"";
    for (int i = 0; i < self.goodsCartList.count; i++) {
        NSString *shopID = @"self";
        NSNumber *idNUmber = ((NSDictionary *)self.shopStores[i])[@"id"];
        if (idNUmber.longValue != 0) {
            shopID = [NSString stringWithFormat:@"%lu",idNUmber.longValue];
        }
        [transportIds setObject:self.transArray[i] forKey:shopID];
        [msgsDic setObject:self.feedArray[i] forKey:shopID];
        ShopManager *shop = self.shopArray[i];
        if (shop.youhuiId != 0) {
            [youhuiIds setObject:@(shop.youhuiId) forKey:shopID];
        }
        for (int i = 0; i < shop.goodsArray.count; i++) {
            GoodsManager *goodsInfo = shop.goodsArray[i];
            if (goodsInfo.isSelectedIntegral) {
                integralIds = [[NSString stringWithFormat:@"%lu,",goodsInfo.gcId.longValue] stringByAppendingString:integralIds];
            }
        }
    }
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Loading";
    [self.progressHUD show:YES];
    if (integralIds.length > 1) {
        integralIds = [integralIds substringToIndex:integralIds.length-1];
    }
    [self.createOrder createOrder:addrID.longValue transportIds:transportIds msgs:msgsDic couponIds:youhuiIds integralIds:integralIds gcIds:self.gcIds];
}


#pragma mark - 显示收货管理界面
- (void)showManagerAddressVC {
    WSJManagerAddressViewController *addressVC = [[WSJManagerAddressViewController alloc] init];
    [self.navigationController pushViewController:addressVC animated:YES];
    addressVC.selectAddress = ^ (NSDictionary *dic) {
        [self changeAddress:[self.shopCenterReformer getAddressfromData:dic]];
        [self.transManager getTransportCartIds:self.gcIds areaId:dic[@"areaId"]];
    };
}

- (void)setfeedBack:(NSIndexPath *)indexPath feedBack:(NSString *)feedBack {
    self.feedArray[indexPath.row-1] = feedBack;
}

- (void)changeYouhui:(NSIndexPath *)indexPath youhuiPrice:(double)youhuiPrice youhuiId:(NSNumber *)youhuiId
{
    GoodsPayTableViewCell *shopCell = (GoodsPayTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [shopCell setYouhuiPrice:youhuiPrice];
    ShopManager *shop = self.shopArray[indexPath.row-1];
    shop.youhuiId = youhuiId.longValue;
    shop.youhuiVaule = youhuiPrice;
    [shopCell setTotalPrice:shop.totalPrice];
}

- (void)changeYouhui:(NSIndexPath *)indexPath {
    NSArray *couponInfoArray = (NSArray *)self.couponInfoList[indexPath.row-1];
    NSMutableArray *couponName = [[NSMutableArray alloc] initWithObjects:@"不使用优惠劵", nil];
    NSMutableArray *couponAmount = [[NSMutableArray alloc] initWithObjects:@(0.00), nil];
    NSMutableArray *couponIDs = [[NSMutableArray alloc] initWithObjects:@(0), nil];
    NSMutableArray *couponAmounts = [[NSMutableArray alloc] initWithObjects:@(0), nil];
    
    
    for (NSDictionary *couponDic in couponInfoArray) {
        NSNumber *couponOrderAmount = couponDic[@"coupon"][@"couponOrderAmount"];
        [couponAmounts addObject:couponOrderAmount];
        [couponName addObject:couponDic[@"coupon"][@"couponName"]];
        [couponAmount addObject:couponDic[@"coupon"][@"couponAmount"]];
        [couponIDs addObject:couponDic[@"id"]];
    }
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, NSString *transport) {
        ShopManager *shop;
//        if (selectedIndex == 0) {
            shop = self.shopArray[0];
//        } else {
//            shop = self.shopArray[selectedIndex-1];
//        }
        NSNumber *couponOrderAmount = couponAmounts[selectedIndex];
        if (shop.goodsRealPrice >= couponOrderAmount.longValue) {
            [self changeYouhui:indexPath youhuiPrice:((NSNumber *)couponAmount[selectedIndex]).longValue youhuiId:couponIDs[selectedIndex]];
            GoodsPayTableViewCell *shopCell = (GoodsPayTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            shopCell.useCouponLab.text = transport;
            [shopCell updateGoodTotalPrice];
            [self updateTotlaPrice];
        } else {
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"您的消费额度不足,无法使用此优惠劵"
                                                            delegate:self
                                                   cancelButtonTitle:nil
                                                   otherButtonTitles:@"确定", nil];
            [alertV show];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
    };
    ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc] initWithTitle:@"选择优惠劵" rows:couponName.copy initialSelection:0 doneBlock:done cancelBlock:cancel origin:self.view];
    [actionPicker showActionSheetPicker];
}

- (void)changeShopTransport:(NSIndexPath *)indexPath way:(NSString *)transport
{
    GoodsPayTableViewCell *shopCell = (GoodsPayTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [shopCell setTransport:transport];
    self.transArray[indexPath.row-1] = transport;
    ((ShopManager *)self.shopArray[indexPath.row-1]).seletedTransport = transport;
}

- (void)changeTransport:(NSIndexPath *)indexPath {
    NSArray *transArray = (NSArray *)self.transList[indexPath.row-1];
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, NSString *transport) {
        [self changeShopTransport:indexPath way:transport];
        [self updateTotlaPrice];
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
    };
    ActionSheetStringPicker *actionPicker = [[ActionSheetStringPicker alloc] initWithTitle:@"选择物流" rows:transArray.copy initialSelection:0 doneBlock:done cancelBlock:cancel origin:self.view];
    [actionPicker showActionSheetPicker];
}

- (void)changeAddress:(NSDictionary *)addressDic {
    [self.addressCell changeAddress:addressDic];
    self.reformedAddressData = addressDic;
}

- (void)updateTotlaPrice {
    double price = 0.0;
    for (int i = 0; i < self.goodsCartList.count; i++) {
        ShopManager *shop = self.shopArray[i];
        price += shop.totalPrice.doubleValue;
    }
    [self setTotalPriceNumber:price];
}

#pragma mark - private methods
- (void)hiddenSubviews:(BOOL)hidden {
    for (UIView *subView in self.view.subviews) {
        subView.hidden = hidden;
    }
}

- (NSString *)getShopCartGoodsIdsForShopCartGoods:(NSArray *)shopCartGoods {
    
    if (!shopCartGoods.count) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:shopCartGoods.count];
    for (NSArray *shopGoodsArr in shopCartGoods) {
        for (NSDictionary *dic in shopGoodsArr) {
            [arr addObject:dic[@"id"]];
        }
    }
    
    return [arr componentsJoinedByString:@","];
}

- (void)setTotalPriceNumber:(double)price {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计: ¥ %.2f",price] ];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont systemFontOfSize:13.0],NSFontAttributeName,
                                    status_color,NSForegroundColorAttributeName,
                                    nil
                                   ];
    NSRange range = [attributedString.string rangeOfString:@"¥"];
    range = NSMakeRange(range.location, attributedString.length - range.location);
    [attributedString addAttributes:attributeDict range:range];
    
    self.totalPrice.attributedText = attributedString.copy;
}

- (void)initTableView {
    self.tableView.fd_debugLogEnabled = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 95.5;
    self.tableView.rowHeight = 95.5;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UINib *nibCell = [UINib nibWithNibName:@"GoodsPayTableViewCell" bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
    UINib *headCell = [UINib nibWithNibName:cellIdentifierHead bundle:nil];
    [self.tableView registerNib:headCell forCellReuseIdentifier:cellIdentifierHead];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)setUIContent {
    self.title = @"确认订单";
    [self setTotalPriceNumber:0.00];
    [self initTableView];
    [self hiddenSubviews:YES];

}

- (UIView *)lineView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    return lineView;
}

- (void)setViewsMASConstraint {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@47);
    }];
    UIView *lineView = [self lineView];
    [self.bottomView addSubview:lineView];
    CGFloat onePXHeight = 1 / [UIScreen mainScreen].scale;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(onePXHeight));
        make.top.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView);
    }];
    
    UIView *superView = self.bottomView;
    [self.payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView);
        make.bottom.equalTo(superView);
        make.right.equalTo(superView);
        make.width.equalTo(@100);
    }];
    [self.totalPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.right.equalTo(self.payBtn.mas_left).with.offset(-18);
    }];
}

#pragma mark - getters and settters


- (id<AddressReformerProtocol>)shopCenterReformer {
    if (_shopCenterReformer == nil) {
        _shopCenterReformer = [[ShopCenterListReformer alloc] init];
    }
    
    return _shopCenterReformer;
}

- (APIManager *)createOrder {
    if (_createOrder == nil) {
        _createOrder = [[APIManager alloc] init];
        _createOrder.delegate = self;
    }
    
    return _createOrder;
}


- (APIManager *)orderConfirmManager {
    if (_orderConfirmManager == nil) {
        _orderConfirmManager = [[APIManager alloc] init];
        _orderConfirmManager.delegate = self;
    }

    return _orderConfirmManager;
}

- (APIManager *)buyNowManager {
    
    if (_buyNowManager == nil) {
        _buyNowManager = [[APIManager alloc] init];
        _buyNowManager.delegate = self;
    }
    return _buyNowManager;

}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    [self setUIContent];
    
}

@end
