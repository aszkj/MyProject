//
//  PaymentHelper.m
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "PaymentHelper.h"
#import "Order.h"
#import "Product.h"
#import "AlipayResultInfo.h"
#import "PrepayInfo.h"

@implementation PaymentHelper

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedCache = nil;
    dispatch_once(&pred, ^{
        _sharedCache = [[self alloc] init]; // or some other init method
    });
    return _sharedCache;
}

- (void)startAlipayWith:(Product *)product paySignature:(NSString *)signedStr delegate:(id<CWAlipayDelegate>)delegate
{
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"BaiYing_Thinker";
    
    [[AlipaySDK defaultService] payOrder:signedStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSInteger resultStatus = [resultDic[@"resultStatus"] integerValue];
        [self messageFromResultStatus:resultStatus];
        
        if (resultStatus == 9000) {//支付宝支付成功查询服务器
            //查询服务器订单状态
            //开启订单查询
            if (delegate && [delegate respondsToSelector:@selector(alipayCompleteCallback:)]) {
                [delegate alipayCompleteCallback:resultDic];
            }
            
        }else{//支付宝支付失败
            [self performSelector:@selector(payFailed) withObject:nil afterDelay:2.0];
        }
    }];
}

- (void)startWXPayWithPrepayInfo:(PrepayInfo *)prepayInfo delegate:(id<WXApiDelegate>)delegate {
    time_t  now;
    time(&now);
    
    //调起微信支付
    PayReq* payReq = [[PayReq alloc] init];
    payReq.openID      = prepayInfo.appid;
    payReq.partnerId   = prepayInfo.partnerid;
    payReq.prepayId    = prepayInfo.prepayid;
    payReq.nonceStr    = prepayInfo.noncestr;
    payReq.timeStamp   = (UInt32)prepayInfo.timestamp.integerValue;//(UInt32)now;
    payReq.package     = prepayInfo.package;
    payReq.sign        = prepayInfo.sign;
    [WXApi safeSendReq:payReq];
    [WXApi handleOpenURL:nil delegate:delegate];
}

- (NSString *)messageFromResultStatus:(NSInteger )resultStatus
{
    NSString *message;
    switch (resultStatus) {
        case 9000:
            message = @"订单支付成功";
            break;
            
        case 8000:
            message = @"正在处理中";
            break;
            
        case 4000:
            message = @"订单支付失败";
            break;
            
        case 6001:
            message = @"用户取消支付";
            break;
            
        case 6002:
            message = @"网络连接错误";
            break;
            
        default:
            break;
    }
    return message;
}

#pragma mark - 支付失败
-(void)payFailed{
    
}

@end
