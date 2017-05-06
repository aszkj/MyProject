//
//  CDVViewController+cordovaExtend.m
//  YilidiBuyer
//
//  Created by mm on 16/12/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CDVViewController+cordovaExtend.h"
#import "GlobleConst.h"
#import "Util.h"
#import "GoodsModel.h"
#import <MJExtension/NSObject+MJKeyValue.h>

@implementation CDVViewController (cordovaExtend)

- (void)callJsMethodConfigure {
    
    [self _deliveryAppVersionInfoToJs];
    
    [self _deliverySessionInfoToJs];

    
    [self _deliverUserInfoToJs];
    
}

- (void)_deliverySessionInfoToJs {
    NSString *sessionIdStr = SESSIONID ? SESSIONID : UNLOGIN_SESSIONID;
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corUserSessionId('%@')",sessionIdStr] completionHandler:^(id o, NSError *error) {
        
    }];
}

- (void)_deliveryAppVersionInfoToJs {
    NSString *appVersionStr = [Util appVersionStr];
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corVersionCode('%@')",appVersionStr] completionHandler:^(id o, NSError *error) {
        
    }];
}



- (void)_deliverUserInfoToJs {
//    NSDictionary *userInfo = [kUserDefaults objectForKey:KUserInfoKey];
//    NSString *jsonUserInfoStr = [userInfo JSONString];
//    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corUserInfo('%@')",jsonUserInfoStr] completionHandler:^(id o, NSError *error) {
//        
//    }];
}


@end
