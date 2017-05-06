//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopGoodsTypeProperty.h"

@implementation ShopGoodsTypeProperty
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"display":@"display",
			@"name":@"name",
			@"sequence":@"sequence",
			@"goodsTypeId":@"goodsTypeId",
			@"hcValue":@"hcValue",
			@"value":@"value"
             };
}

@end
