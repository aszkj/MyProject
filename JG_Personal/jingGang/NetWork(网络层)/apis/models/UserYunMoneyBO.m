//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UserYunMoneyBO.h"

@implementation UserYunMoneyBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"pdOpType":@"pdOpType",
			@"addTime":@"addTime",
			@"pdLogAmount":@"pdLogAmount",
			@"pdLogInfo":@"pdLogInfo",
			@"balance":@"balance"
             };
}

@end
