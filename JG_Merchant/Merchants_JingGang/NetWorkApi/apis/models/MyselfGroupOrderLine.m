//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "MyselfGroupOrderLine.h"

@implementation MyselfGroupOrderLine
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"status":@"status",
			@"storeName":@"storeName",
			@"localGroupName":@"localGroupName",
			@"totalPrice":@"totalPrice",
			@"orderStatus":@"orderStatus",
			@"localReturnStatus":@"localReturnStatus",
			@"userNickname":@"userNickname",
			@"mobile":@"mobile",
			@"orderId":@"orderId",
			@"addTime":@"addTime"
             };
}

@end
