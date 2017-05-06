//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OrderBO.h"

@implementation OrderBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"goodsId":@"goodsId",
			@"igoOrderSn":@"igoOrderSn",
			@"igoStatus":@"igoStatus",
			@"igoTotalIntegral":@"igoTotalIntegral",
			@"igoTransFee":@"igoTransFee",
			@"goodsCount":@"goodsCount",
			@"goodsImg":@"goodsImg",
			@"goodsName":@"goodsName"
             };
}

@end
