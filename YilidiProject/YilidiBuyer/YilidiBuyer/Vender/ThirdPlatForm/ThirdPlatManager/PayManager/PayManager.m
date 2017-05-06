//
//  PayManager.m
//  YilidiBuyer
//
//  Created by yld on 16/7/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "PayManager.h"
#import "AliPayResponseModel.h"
#import "ProjectRelativeDefineNotification.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Util.h"
//应用注册scheme,在AlixPayDemo-Info.plist定义URL types
static NSString *alipayScheme = @"yilidiAlipay";

@interface PayManager()

@property (nonatomic, strong)WXinpayResponseBlock wxinpayResponseBlock;
@property (nonatomic, strong)AlipayResponseBlock alipayResponseBlock;

@end

@implementation PayManager

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _shareManager = nil;
    dispatch_once(&pred, ^{
        _shareManager = [[self alloc] init]; // or some other init method
    });
    return _shareManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _registerPayResultNotification];
    }
    return self;
}

- (void)_registerPayResultNotification {
    [kNotification addObserver:self selector:@selector(wxPayResult:) name:KNotificationWXPayResult object:nil];
    [kNotification addObserver:self selector:@selector(aliPayResult:) name:KNotificationAliPayResult object:nil];

}

- (void)startAlipayWithPaySignature:(NSString *)signedStr
                      responseBlock:(AlipayResponseBlock)alipayResponseBlock
{
    self.alipayResponseBlock = alipayResponseBlock;
    [[AlipaySDK defaultService] payOrder:signedStr fromScheme:alipayScheme callback:^(NSDictionary *resultDic) {
        JLog(@"支付宝回调结果 %@",resultDic);
        AliPayResponseModel *responseModel = [[AliPayResponseModel alloc] initWithDefaultDataDic:resultDic];
        alipayResponseBlock(responseModel);
    }];
}

- (void)startWXinpayWithWxinPreparePayModel:(WXPayRequestModel *)wxPayRequestModel
                              responseBlock:(WXinpayResponseBlock)wxinpayResponseBlock
{
    if (![WXApi isWXAppInstalled]) {
        [Util ShowAlertWithOnlyMessage:@"未安装微信客户端，无法进行支付"];
        return;
    }
    
    self.wxinpayResponseBlock = wxinpayResponseBlock;
    //发起微信支付，设置参数
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = wxPayRequestModel.partnerid;
    request.prepayId = wxPayRequestModel.prepayid;
    request.package = wxPayRequestModel.package1;
    request.nonceStr = wxPayRequestModel.noncestr;
    request.timeStamp = (UInt32)wxPayRequestModel.timestamp.longLongValue;
    request.sign = wxPayRequestModel.sign;
    request.openID = wxPayRequestModel.appid;
    //调用微信
    [WXApi sendReq:request];
}

#pragma mark -------------------Notification Method----------------------
- (void)wxPayResult:(NSNotification *)info {
    WXinPayResponseModel *responseModel = info.object;
    emptyBlock(self.wxinpayResponseBlock,responseModel);
}

- (void)aliPayResult:(NSNotification *)info {
    AliPayResponseModel *responseModel = info.object;
    emptyBlock(self.alipayResponseBlock,responseModel);
}

- (void)dealloc
{
    [kNotification removeObserver:self];
}


@end
