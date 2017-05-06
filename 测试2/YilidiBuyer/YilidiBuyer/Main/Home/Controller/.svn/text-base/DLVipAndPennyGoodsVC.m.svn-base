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
#import "UIViewController+unLoginHandle.h"

#define VIPH5Url jFormat(@"%@/h5/market.html",ServerDomain)

@interface DLVipAndPennyGoodsVC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DLVipAndPennyGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initTitle];
    
    [self _loadActivityH5UrlStr];

}

#pragma mark -------------------Init Method----------------------
-(void)_initTitle {
    
    NSString *pageTitle = nil;
    if ([self.h5typeCode isEqualToString:H5PAGETYPE_UPGRADE_VIP]) {
        pageTitle = @"升级VIP";
    }else if ([self.h5typeCode isEqualToString:H5PAGETYPE_REGISTER_GIFT]){
        pageTitle = @"新人专享";
    }else if ([self.h5typeCode isEqualToString:H5PAGETYPE_PARTNER_JOIN]){
        pageTitle = @"全面招募";
    }else if ([self.h5typeCode isEqualToString:H5PAGETYPE_ABOUT_US]){
        pageTitle = @"关于我们";
    }else if ([self.h5typeCode isEqualToString:H5PAGETYPE_MILK_PROMOTION]){
        pageTitle = @"牛奶促销";
    }else if ([self.h5typeCode isEqualToString:H5PAGETYPE_COMMON_QUESTION]){
        pageTitle = @"常见问题";
    }else if ([self.h5typeCode isEqualToString:H5PAGETYPE_SHARE_PAGE]){
        pageTitle = @"分享有礼";
    }

    self.pageTitle = pageTitle;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"nav_Back" target:self action:@selector(_backPage)];
    
    
}

- (void)_backPage {

    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)_init {
    
    if (!isEmpty(self.infoDic)) {
        self.h5typeCode = self.infoDic[kLinkDataKeyH5Page];
    }
    
    if (isEmpty(self.h5typeCode)) {
        self.h5typeCode = H5PAGETYPE_UPGRADE_VIP;
    }
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"addVipToCart"];
    [userContentController addScriptMessageHandler:self name:@"addFenToCart"];
    [userContentController addScriptMessageHandler:self name:@"toVipHtml"];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    configuration.selectionGranularity = WKSelectionGranularityCharacter;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) configuration:configuration];
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;

    [self.view addSubview:self.webView];

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
            NSURL *url = [NSURL URLWithString:urlStr];
            [weak_self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    }];
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
    return [self _goodsModelOfGoodsBarCode:goodsBarCode atGoodsArr:pennyGoods];
    
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

- (void)addFenToCart:(NSNumber *)goodsBarCode {
    //一分钱商品是从一分钱商品list中取第一个加进购物车，而不是从数组中找
    GoodsModel *goodsModel = [[[DLGlobleRequestApiManager sharedManager] pennyGoods] firstObject];
    if (isEmpty(goodsModel)) {
        [Util ShowAlertWithOnlyMessage:@"暂无该一分钱商品!"];
        return;
    }
    goodsModel.goodsType = GoodsType_NormalPennyGoods;
    [self _addShopCartForGoodsModel:goodsModel];
}

- (void)toVipHtml:(NSNumber *)goodsId{
    NSURL *url = [NSURL URLWithString:VIPH5Url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterShopCartPage {
    if (![self unloginHandle]) {
        return;
    }
    DLShopCarVC *shopCartPage = [[DLShopCarVC alloc] init];
    [self navigatePushViewController:shopCartPage animate:YES];
}

#pragma mark -------------------Delegate Method----------------------
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
//    [self showHubWithDefaultStatus];

}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [self dissmiss];

}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    [self dissmiss];
}


#pragma mark - WKScriptMessageHandler delegate
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    DDLogVerbose(@"方法名:%@", message.name);
    DDLogVerbose(@"参数:%@", message.body);
    // 方法名
    NSString *methods = [NSString stringWithFormat:@"%@:", message.name];
    SEL selector = NSSelectorFromString(methods);
    // 调用方法
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:message.body];
    } else {
        JLog(@"未实现方法：%@", methods);
    }
}







@end
