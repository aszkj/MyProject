//
//  WXinPayResponseModel.m
//  YilidiBuyer
//
//  Created by yld on 16/7/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "WXinPayResponseModel.h"

@implementation WXinPayResponseModel

- (void)setWeixinResp:(PayResp *)weixinResp {
    _weixinResp = weixinResp;
    self.payType = PayType_WxPay;
    self.payTypeStr = @"微信支付";
    [self _setPayStatus];
}

- (void)_setPayStatus {
    NSString *statusStr = nil;
    PayResult payResult = PayResult_Success;
    switch (self.weixinResp.errCode) {
        case WXSuccess:
        {
            JLog(@"wxi pay 支付结果: 成功!");
            statusStr = @"支付成功";
            payResult = PayResult_Success;
        }
            break;
        case WXErrCodeCommon:
        { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
            
            JLog(@"wxi pay  支付结果: 失败!");
            statusStr = @"支付失败";
            payResult = PayResult_Failed;
        }
            break;
        case WXErrCodeUserCancel:
        { //用户点击取消并返回
            JLog(@"wxi pay  支付结果: 取消!");
            statusStr = @"取消支付";
            payResult = PayResult_Canceled;

        }
            break;
        case WXErrCodeSentFail:
        { //发送失败
            JLog(@"发送失败");
            statusStr = @"发送失败";
            payResult = PayResult_Failed;

        }
            break;
        case WXErrCodeUnsupport:
        { //微信不支持
            JLog(@"微信不支持");
            statusStr = @"微信不支持";
            payResult = PayResult_Failed;

        }
            break;
        case WXErrCodeAuthDeny:
        { //授权失败
            JLog(@"授权失败");
            statusStr = @"微信不支持";
            payResult = PayResult_Failed;

        }
            break;
        default:
            break;
    }
    self.statusStr = statusStr;
    self.payResult = payResult;
}


@end
