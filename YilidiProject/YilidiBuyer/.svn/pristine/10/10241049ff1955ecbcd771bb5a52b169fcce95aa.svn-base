//
//  PayManager+requestPayNeedInfo.m
//  YilidiBuyer
//
//  Created by yld on 16/7/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "PayManager+requestPayNeedInfo.h"

@implementation PayManager (requestPayNeedInfo)

- (void)requestAliPayInfoWithPayRequestModel:(PayRequestModel *)payRequestModel
                               payRequesBack:(PayInfoBackBlock)payInfoBackBlock
{
    NSDictionary *param = @{@"saleOrderNo":payRequestModel.orderNo};
    [AFNHttpRequestOPManager postWithParameters:param subUrl:kUrl_AliPayNeedInfo block:^(NSDictionary *resultDic, NSError *error) {
        emptyBlock(payInfoBackBlock,resultDic,error);
    }];
}

- (void)requestWxPayInfoWithPayRequestModel:(PayRequestModel *)payRequestModel
                              payRequesBack:(PayInfoBackBlock)payInfoBackBlock
{
    NSDictionary *param = @{@"saleOrderNo":payRequestModel.orderNo};
    [AFNHttpRequestOPManager postWithParameters:param subUrl:kUrl_WxPayNeedInfo block:^(NSDictionary *resultDic, NSError *error) {
        emptyBlock(payInfoBackBlock,resultDic,error);
    }];
}


@end
