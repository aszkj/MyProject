//
//  CDVViewController+cordovaExtend.m
//  YilidiBuyer
//
//  Created by mm on 16/12/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CDVViewController+cordovaExtend.h"
#import "GlobleConst.h"
#import "ShopCartGoodsManager.h"
#import "Util.h"
#import "GoodsModel.h"
#import <MJExtension/NSObject+MJKeyValue.h>

@implementation CDVViewController (cordovaExtend)

- (void)callJsMethodConfigure {
    
    [self _deliveryAppVersionInfoToJs];
    
    [self _deliverySessionInfoToJs];

    [self _deliverCartInfoToJs];
    
    [self _deliveryStoreInfoToJs];
    
    [self _deliveryCommunityInfoToJs];
    
    [self _deliverUserInfoToJs];
    
    [self _deliverUserLocationInfoToJs];
}

- (void)_deliverySessionInfoToJs {
    NSString *sessionIdStr = SESSIONID;
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corUserSessionId('%@')",sessionIdStr] completionHandler:^(id o, NSError *error) {
        
    }];
}

- (void)_deliveryAppVersionInfoToJs {
    NSString *appVersionStr = [Util appVersionStr];
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corVersionCode('%@')",appVersionStr] completionHandler:^(id o, NSError *error) {
        
    }];
}


- (void)_deliverUserLocationInfoToJs {
    NSNumber *userLongtitude = [kUserDefaults objectForKey:KLongtitudeKey];
    NSNumber *userLatitude = [kUserDefaults objectForKey:KLatitudeKey];
    
    NSDictionary *userLocationInfo = @{KLongtitudeKey:userLongtitude,
                                       KLatitudeKey:userLatitude};

    NSString *jsonUserLocationInfoStr = [userLocationInfo JSONString];
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corLocationInfo('%@')",jsonUserLocationInfoStr] completionHandler:^(id o, NSError *error) {
        
    }];
}


- (void)_deliverUserInfoToJs {
    NSDictionary *userInfo = [kUserDefaults objectForKey:KUserInfoKey];
    NSString *jsonUserInfoStr = [userInfo JSONString];
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corUserInfo('%@')",jsonUserInfoStr] completionHandler:^(id o, NSError *error) {
        
    }];
}

- (void)_deliveryStoreInfoToJs {
    StoreModel *storeModel = kCurrentStore;
    NSString *jsonStoreInfoStr = [[storeModel modelDic] JSONString];
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corStoreInfo('%@')",jsonStoreInfoStr] completionHandler:^(id o, NSError *error) {
        
    }];

}

- (void)_deliveryCommunityInfoToJs {
    CommunityModel *communityModel = kCurrentCummunity;
    NSString *jsonCommunityInfoStr = [[communityModel modelDic] JSONString];
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corCommunityInfo('%@')",jsonCommunityInfoStr] completionHandler:^(id o, NSError *error) {
        
    }];
}


- (void)_deliverCartInfoToJs {
    NSDictionary *cartInfoDic = (NSDictionary *)[ShopCartGoodsManager sharedManager].goodsShopCartDictionary;
    NSMutableDictionary *newCartInfo = [NSMutableDictionary dictionaryWithCapacity:cartInfoDic.count];
    [cartInfoDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, GoodsModel* obj, BOOL * _Nonnull stop) {
        [newCartInfo setObject:[obj goodsModelDic] forKey:key];
    }];
    
    NSString *jsonCartInfoStr = [newCartInfo JSONString];
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corCartInfo('%@')",jsonCartInfoStr] completionHandler:^(id o, NSError *error) {
        
    }];

}

@end
