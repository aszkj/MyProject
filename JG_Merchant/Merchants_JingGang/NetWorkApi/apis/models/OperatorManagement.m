//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorManagement.h"

@implementation OperatorManagement
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"storeName":@"storeName",
			@"storeTelephone":@"storeTelephone",
			@"rebateConsumeAmount":@"rebateConsumeAmount",
			@"rebateFeeAmount":@"rebateFeeAmount",
			@"rebateTotal":@"rebateTotal",
			@"tradingTotal":@"tradingTotal",
			@"storeId":@"storeId"
             };
}

@end
