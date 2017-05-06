//
//  CDVViewController+cordovaExtend.m
//  YilidiBuyer
//
//  Created by mm on 16/12/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CDVViewController+cordovaExtend.h"
#import "GlobleConst.h"

@implementation CDVViewController (cordovaExtend)

- (void)callJsMethodConfigure {
    
    NSString *sessionIdStr = SESSIONID ? SESSIONID : UNLOGIN_SESSIONID;
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corUserSessionId('%@')",sessionIdStr] completionHandler:^(id o, NSError *error) {
        
    }];
    
    [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"corAppLoadFlag('%@')",@"webPageHasFinishLoaded"] completionHandler:^(id o, NSError *error) {
        
    }];

}

@end
