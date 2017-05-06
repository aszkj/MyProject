//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorRelationList.h"

@implementation OperatorRelationList
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"operatorRegisterCount":@"operatorRegisterCount",
			@"storeRegisterCount":@"storeRegisterCount",
			@"userRegisterCount":@"userRegisterCount",
			@"areaOperatorCount":@"areaOperatorCount",
			@"membershipCount":@"membershipCount",
			@"membershipUserCount":@"membershipUserCount"
             };
}

@end
