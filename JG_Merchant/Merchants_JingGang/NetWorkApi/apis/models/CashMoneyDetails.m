//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CashMoneyDetails.h"

@implementation CashMoneyDetails
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"cashAmount":@"cashAmount",
			@"addTime":@"addTime",
			@"cashStatus":@"cashStatus"
             };
}

@end
