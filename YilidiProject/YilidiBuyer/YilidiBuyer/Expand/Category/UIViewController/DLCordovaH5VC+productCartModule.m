//
//  DLCordovaH5VC+productCartModule.m
//  YilidiBuyer
//
//  Created by mm on 16/12/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCordovaH5VC+productCartModule.h"
#import "GlobleConst.h"
#import "DLGlobleRequestApiManager.h"
#import "ShopCartGoodsManager+checkWhenAddingShopCart.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLShopCarVC.h"
#import "ProjectRelativeKey.h"
#import "ProductCart.h"
#import "Operation.h"
#import "UIViewController+unLoginHandle.h"
#import "NSString+Teshuzifu.h"

@implementation DLCordovaH5VC (productCartModule)

- (void)initProductCartPlugin {
    ProductCart *productCart = (ProductCart *)[self getCommandInstance:@"ProductCart"];
    WEAK_SELF
    productCart.htmlAddFenToCartBlock = ^(NSString *goodsBarCode){
        [weak_self addFenToCart:goodsBarCode];
    };
    
    productCart.htmlAddVIPToCartBlock = ^(NSString *goodsBarCode){
        [weak_self addVipToCart:goodsBarCode];
    };
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

#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterShopCartPage {
    if (![self unloginHandle]) {
        return;
    }
    DLShopCarVC *shopCartPage = [[DLShopCarVC alloc] init];
    [self.navigationController pushViewController:shopCartPage animated:YES];
}



@end


