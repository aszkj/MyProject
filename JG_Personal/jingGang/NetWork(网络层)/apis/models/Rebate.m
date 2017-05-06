//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "Rebate.h"

@implementation Rebate
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"totalRebateAmout":@"totalRebateAmout",
			@"rebateAmount":@"rebateAmount",
			@"years":@"years",
			@"months":@"months",
			@"localGroupName":@"localGroupName",
			@"nickname":@"nickname",
			@"mobile":@"mobile",
			@"groupSn":@"groupSn",
			@"userNickName":@"userNickName",
			@"createTime":@"createTime",
			@"monthTotalPrice":@"monthTotalPrice",
			@"ggName":@"ggName",
			@"rabate":@"rabate",
			@"rebateType":@"rebateType"
             };
}

@end
