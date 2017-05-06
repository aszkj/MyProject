//
//  PayManager+requestPayNeedInfo.h
//  YilidiBuyer
//
//  Created by yld on 16/7/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "PayManager.h"
#import "PayRequestModel.h"

typedef void(^PayInfoBackBlock)(NSDictionary *dic,NSError *error);
@interface PayManager (requestPayNeedInfo)

- (void)requestAliPayInfoWithPayRequestModel:(PayRequestModel *)payRequestModel
                               payRequesBack:(PayInfoBackBlock)payInfoBackBlock;

- (void)requestWxPayInfoWithPayRequestModel:(PayRequestModel *)payRequestModel
                               payRequesBack:(PayInfoBackBlock)payInfoBackBlock;


@end
