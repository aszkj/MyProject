//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsInventoryDetail.h"

@implementation GoodsInventoryDetail
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"integralPrice":@"integralPrice",
			@"price":@"price",
			@"integralCount":@"integralCount",
			@"count":@"count",
			@"mobilePrice":@"mobilePrice"
             };
}

@end
