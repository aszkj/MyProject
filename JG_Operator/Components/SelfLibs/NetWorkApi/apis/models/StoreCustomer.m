//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "StoreCustomer.h"

@implementation StoreCustomer
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"relationType":@"relationType",
			@"accountCreateTime":@"accountCreateTime",
			@"nickname":@"nickname",
			@"mobile":@"mobile"
             };
}

@end
