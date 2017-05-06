//
//  AliPayResponseModel.m
//  YilidiBuyer
//
//  Created by yld on 16/7/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "AliPayResponseModel.h"


@implementation AliPayResponseModel

-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        self.statusCode = [dic[@"resultStatus"] integerValue];
        self.payType = PayType_Alipay;
        self.payTypeStr = @"支付宝支付";
        self.resultSignStr = dic[@"result"];
        [self _setStatusStrStatusType];
    }
    return self;
}

- (void)_setStatusStrStatusType {
    NSString *message;
    PayResult payResult = PayResult_Success;
    switch (self.statusCode) {
        case 9000:
            message = @"订单支付成功";
            payResult = PayResult_Success;
            break;
            
        case 8000:
            message = @"正在处理中";
            payResult = PayResult_Failed;
            break;
            
        case 4000:
            message = @"订单支付失败";
            payResult = PayResult_Failed;
            break;
            
        case 6001:
            message = @"取消支付";
            payResult = PayResult_Canceled;
            break;
            
        case 6002:
            message = @"网络连接错误";
            payResult = PayResult_Failed;
            break;
            
        default:
            break;
    }
    self.statusStr = message;
    self.payResult = payResult;
    if (self.payResult == PayResult_Success) {
        if (![self.resultSignStr containsString:@"success=\"true\""]) {
            self.statusStr = @"支付失败,回调签名错误";
            self.payResult = PayResult_Failed;
        }
    }
}

@end
