//
//  AFNHttpRequestOPManager+checkNetworkStatus.m
//  YilidiBuyer
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AFNHttpRequestOPManager+checkNetworkStatus.h"

@implementation AFNHttpRequestOPManager (checkNetworkStatus)

+ (void)checkNetWorkStatus{
    /**
          *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
          *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
          *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
          *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
          */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            
            JLog(@"网络连接已断开，请检查您的网络！");
            
            return ;
        }
    }];
    
}

+ (void)checkNetWorkStatusBackBlock:(void (^)(AFNetworkReachabilityStatus status))block {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        block(status);
    }];
    
}


@end

