//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsInfo.h"

@implementation GoodsInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"goodsPrice":@"goodsPrice",
			@"goodsSnapshoot":@"goodsSnapshoot",
			@"goodsGspVal":@"goodsGspVal",
			@"goodsAllPrice":@"goodsAllPrice",
			@"goodsId":@"goodsId",
			@"goodsType":@"goodsType",
			@"goodsName":@"goodsName",
			@"goodsDomainPath":@"goodsDomainPath",
			@"goodsChoiceType":@"goodsChoiceType",
			@"goodsMainphotoPath":@"goodsMainphotoPath",
			@"goodsGspIds":@"goodsGspIds",
			@"goodsPayoffPrice":@"goodsPayoffPrice",
			@"goodsCommissionPrice":@"goodsCommissionPrice",
			@"goodsCommissionRate":@"goodsCommissionRate",
			@"storeDomainPath":@"storeDomainPath",
			@"goodsCount":@"goodsCount",
			@"goodsReturnStatus":@"goodsReturnStatus",
			@"goodsMobilePrice":@"goodsMobilePrice",
			@"goodsIntegralPrice":@"goodsIntegralPrice"
             };
}

@end
