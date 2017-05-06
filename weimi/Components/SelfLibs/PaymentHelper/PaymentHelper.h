//
//  PaymentHelper.h
//  BaiYing_Thinker
//
//  Created by 鹏 朱 on 15/10/29.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@class Product,AlipayResultInfo,PrepayInfo;

@protocol CWAlipayDelegate;

@interface PaymentHelper : NSObject

@property (nonatomic, weak) id<CWAlipayDelegate> alipayDelegate;

+ (id)sharedInstance;

//调用支付宝支付
- (void)startAlipayWith:(Product *)product paySignature:(NSString *)signedStr delegate:(id<CWAlipayDelegate>)delegate;

//调用支付宝支付结果状态码
- (NSString *)messageFromResultStatus:(NSInteger )resultStatus;

//调用微信支付
- (void)startWXPayWithPrepayInfo:(PrepayInfo *)prepayInfo delegate:(id<WXApiDelegate>) delegate;

@end


@protocol CWAlipayDelegate<NSObject>

@optional
- (void)alipayCompleteCallback:(NSDictionary *)resultDic;

@end