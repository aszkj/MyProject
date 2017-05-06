//
//  UManager.m
//  YilidiBuyer
//
//  Created by mm on 17/1/18.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "UManager.h"
#import "UMMobClick/MobClick.h"

#ifdef DEBUG
    #define UMAppKey @"58a3bf5545297d61f6000d35"
#else
    #define UMAppKey @"587f3fcb5312dd6d30000879"
#endif

static UManager *_uManager;

@implementation UManager

+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _uManager = [[UManager alloc] init];
    });
    
    return _uManager;
}

+ (void)configureUM{
    UMConfigInstance.appKey = UMAppKey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
}

+ (void)testUM {
    
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    DDLogVerbose(@"UM test data = %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);

}

+ (void)enterPage:(NSString *)page {
    [MobClick beginLogPageView:page];
}

+ (void)leavePage:(NSString *)page {
    [MobClick endLogPageView:page];
}


@end
