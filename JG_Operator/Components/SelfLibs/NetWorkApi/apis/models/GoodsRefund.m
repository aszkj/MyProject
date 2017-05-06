//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsRefund.h"

@implementation GoodsRefund
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"nickName":@"nickName",
			@"groupSn":@"groupSn",
			@"orderTime":@"orderTime",
			@"costPrice":@"costPrice",
			@"ggName":@"ggName",
			@"ggRebate":@"ggRebate",
			@"groupPrice":@"groupPrice",
			@"mobile":@"mobile",
			@"status":@"status"
             };
}

@end
