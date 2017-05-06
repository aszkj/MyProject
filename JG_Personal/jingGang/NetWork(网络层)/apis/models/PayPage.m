//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PayPage.h"

@implementation PayPage
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"availableBalance":@"availableBalance",
			@"goodsName":@"goodsName",
			@"totalPrice":@"totalPrice",
			@"orderId":@"orderId"
             };
}

@end
