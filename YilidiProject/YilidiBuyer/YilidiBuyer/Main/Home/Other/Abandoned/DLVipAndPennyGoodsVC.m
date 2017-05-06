//
//  DLVipAndPennyGoodsVC.m
//  YilidiBuyer
//
//  Created by yld on 16/7/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLVipAndPennyGoodsVC.h"
#import <WebKit/WebKit.h>
#import "GlobleConst.h"
#import "DLGlobleRequestApiManager.h"
#import "ShopCartGoodsManager+checkWhenAddingShopCart.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ProjectRelativeDefineNotification.h"
#import "DLShopCarVC.h"
#import "ProjectRelativeKey.h"
#import "ProductCart.h"
#import "Operation.h"
#import "UIViewController+unLoginHandle.h"
#import "NSString+Teshuzifu.h"
#import "UIViewController+showHiddenBottomBarHandle.h"
#import "CDVViewController+cordovaExtend.h"

#define VIPH5Url jFormat(@"%@/h5/market.html",ServerDomain)

@interface DLVipAndPennyGoodsVC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *statbarMaskView;

@end

@implementation DLVipAndPennyGoodsVC

- (void)viewDidLoad {
    self.wwwFolderName = @"www";
    self.startPage = @"index";
    [super viewDidLoad];
    
    [self _init];
    
    [self _registerNotification];
    
    [self _loadActivityH5UrlStr];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
   
    [self showHiddenBottomBarHandle];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



#pragma mark -------------------Init Method----------------------
- (void)_backPage {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)_registerNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(observeCordovaWebViewFinishedLoad:)
                   name:CDVPageDidLoadNotification  // 加载完成
                 object:nil];
}



-(void)_init {
    
    if (!isEmpty(self.infoDic)) {
        self.h5typeCode = self.infoDic[kLinkDataKeyH5Page];
    }
    
    if (isEmpty(self.h5typeCode)) {
        self.h5typeCode = H5PAGETYPE_UPGRADE_VIP;
    }
    
}

#pragma mark -------------------Private Method----------------------
- (void)_loadActivityH5UrlStr {
    NSDictionary *parameters = @{@"typeCode":self.h5typeCode};
    [self showHubWithDefaultStatus];
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:parameters subUrl:kUrl_GetTypeUrl block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self dissmiss];
        if (error.code!=1) {
            return;
        }else{
            [weak_self dissmiss];
            NSString *urlStr = [NSString stringWithFormat:@"%@",resultDic[EntityKey][@"value"]];
            [self _initCordavaPageWithWebUrl:urlStr];
        }
    }];
}

- (void)_initCordavaPageWithWebUrl:(NSString *)urlStr {
    
   
    [self _loadUlrStr:urlStr];
    
    WEAK_SELF
    ProductCart *productCart = (ProductCart *)[self getCommandInstance:@"ProductCart"];
    productCart.htmlAddFenToCartBlock = ^(NSString *goodsBarCode){
        [weak_self addFenToCart:goodsBarCode];
    };
    
    productCart.htmlAddVIPToCartBlock = ^(NSString *goodsBarCode){
        [weak_self addVipToCart:goodsBarCode];
    };

    Operation *operation = (Operation *)[self getCommandInstance:@"Operation"];
    operation.htmlBackBlock = ^{
        [weak_self _back];
    };
    operation.htmlRedirectBlock = ^(NSString *urlStr){
        [weak_self _loadUlrStr:urlStr];
    };
}

- (void)_loadUlrStr:(NSString *)urlStr {
    self.wwwFolderName = @"www";
    urlStr = [urlStr resolutionCordovaUrlStr];
    self.startPage = urlStr;
    NSURL *url = [self performSelector:@selector(appUrl)];
    if (url)
    {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webViewEngine loadRequest:request];
    }
}

- (void)_back{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)_addShopCartForGoodsModel:(GoodsModel *)goodsModel {
    
    NSString *addShopCartCheckStr = [[ShopCartGoodsManager sharedManager] canbeAddedToShopCartOfGoodsModel:goodsModel];
    if (!isEmpty(addShopCartCheckStr)) {
        [Util ShowAlertWithOnlyMessage:addShopCartCheckStr];
        return;
    }
    
    if (![[ShopCartGoodsManager sharedManager] isAddingTheSameTypeGoodsOfGoodsModel:goodsModel]) {
        [self _alertAddDifferentTypeOfGoodsModel:goodsModel];
        return;
    }
    
    [self _addGoodsLogicWithGoodsModel:goodsModel];
}

- (void)_addGoodsLogicWithGoodsModel:(GoodsModel *)goodsModel {
    
    [[ShopCartGoodsManager sharedManager] addShopCartGoodsWithGoodsModel:goodsModel isInShopCartPage:NO];
    [kNotification postNotificationName:KNotificationShopCartBadgeValueNeedChange object:@(NO)];
    [self _enterShopCartPage];
}



- (GoodsModel *)_goodsModelOfGoodsBarCode:(NSString *)goodsBarCode atGoodsArr:(NSArray *)goodsArr{
    __block GoodsModel *findModel = nil;
    [goodsArr enumerateObjectsUsingBlock:^(GoodsModel *goodsModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([goodsModel.barCode isEqualToString:goodsBarCode]) {
            findModel = goodsModel;
            * stop = YES;
        }
    }];
    return findModel;
}

-(GoodsModel *)vipGoodsModelOfGoodsBarCode:(NSString *)goodsBarCode {
    NSArray *vipGoods = [[DLGlobleRequestApiManager sharedManager] vipGoods];
    return [self _goodsModelOfGoodsBarCode:goodsBarCode atGoodsArr:vipGoods];
}

-(GoodsModel *)pennyGoodsModelOfGoodsBarCode:(NSString *)goodsBarCode {
    
    NSArray *pennyGoods = [[DLGlobleRequestApiManager sharedManager] pennyGoods];
    if (isEmpty(goodsBarCode)) {
        return pennyGoods.firstObject;
    }else {
        return [self _goodsModelOfGoodsBarCode:goodsBarCode atGoodsArr:pennyGoods];
    }
    
}


- (void)_alertAddDifferentTypeOfGoodsModel:(GoodsModel *)goodsModel {
    
    AlertViewManager *alertManager =  [[AlertViewManager alloc] init];
    
    NSString *alertStr = [[ShopCartGoodsManager sharedManager] addingDifferentGoodsTypeAlert];
    
    WEAK_SELF
    //两个action
    [alertManager showAlertViewWithControllerTitle:@"提示" message:alertStr controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        [[ShopCartGoodsManager sharedManager] clearShopCartDataWhenAddingDifferentTypeGoods];
        [weak_self _addGoodsLogicWithGoodsModel:goodsModel];
        
    } otherActionTitle:@"取消" otherActionStyle:UIAlertActionStyleDefault otherAlertViewAction:^(UIAlertAction *action) {
        
    }];
}

- (void)addVipToCart:(NSString *)goodsBarCode {
    GoodsModel *goodsModel = [self vipGoodsModelOfGoodsBarCode:goodsBarCode];
    if (isEmpty(goodsModel)) {
        [Util ShowAlertWithOnlyMessage:@"暂无该VIP商品!"];
        return;
    }
    goodsModel.goodsType = GoodsType_VipGoods;
    [self _addShopCartForGoodsModel:goodsModel];
}

- (void)addFenToCart:(NSString *)goodsBarCode {
    GoodsModel *goodsModel = [self pennyGoodsModelOfGoodsBarCode:goodsBarCode];;
    if (isEmpty(goodsModel)) {
        [Util ShowAlertWithOnlyMessage:@"暂无该一分钱商品!"];
        return;
    }
    goodsModel.goodsType = GoodsType_NormalPennyGoods;
    [self _addShopCartForGoodsModel:goodsModel];
}

- (void)toVipHtml:(NSNumber *)goodsId{
    NSURL *url = [NSURL URLWithString:VIPH5Url];
//    self.pageTitle = @"升级VIP";
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterShopCartPage {
    if (![self unloginHandle]) {
        return;
    }
    DLShopCarVC *shopCartPage = [[DLShopCarVC alloc] init];
    [self.navigationController pushViewController:shopCartPage animated:YES];
}

#pragma mark -------------------Delegate Method----------------------
- (void)observeCordovaWebViewFinishedLoad:(NSNotification *)info  {
    [self MB_hideLoadingHub];
    [self callJsMethodConfigure];
}


@end
