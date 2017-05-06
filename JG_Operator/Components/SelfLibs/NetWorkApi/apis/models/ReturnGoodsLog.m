//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ReturnGoodsLog.h"

@implementation ReturnGoodsLog
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"addTime":@"addTime",
			@"expressCode":@"expressCode",
			@"expressCompanyName":@"expressCompanyName",
			@"expressCompanyId":@"expressCompanyId",
			@"goodsAllPrice":@"goodsAllPrice",
			@"goodsId":@"goodsId",
			@"goodsGspIds":@"goodsGspIds",
			@"goodsMainphotoPath":@"goodsMainphotoPath",
			@"goodsName":@"goodsName",
			@"goodsPrice":@"goodsPrice",
			@"goodsReturnStatus":@"goodsReturnStatus",
			@"goodsType":@"goodsType",
			@"refundStatus":@"refundStatus",
			@"returnContent":@"returnContent",
			@"returnOrderId":@"returnOrderId",
			@"returnServiceId":@"returnServiceId",
			@"selfAddress":@"selfAddress",
			@"storeId":@"storeId"
             };
}

@end
