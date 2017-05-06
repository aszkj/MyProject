//
//  PayManager.h
//  YilidiBuyer
//
//  Created by yld on 16/7/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AliPayResponseModel.h"
#import "WXPayRequestModel.h"
#import "WXinPayResponseModel.h"

typedef void(^AlipayResponseBlock)(AliPayResponseModel *payResponseModel);
typedef void(^WXinpayResponseBlock)(WXinPayResponseModel *payResponseModel);


@interface PayManager : NSObject<UIApplicationDelegate>

+ (id)sharedInstance;

- (void)startAlipayWithPaySignature:(NSString *)signedStr
                      responseBlock:(AlipayResponseBlock)alipayResponseBlock;

- (void)startWXinpayWithWxinPreparePayModel:(WXPayRequestModel *)wxPayRequestModel
                      responseBlock:(WXinpayResponseBlock)wxinpayResponseBlock;


@end
