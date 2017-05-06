//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorMember.h"

@implementation OperatorMember
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"relationType":@"relationType",
			@"createTime":@"createTime",
			@"groupStoreName":@"groupStoreName",
			@"nickname":@"nickname",
			@"relationName":@"relationName",
			@"storeName":@"storeName"
             };
}

@end
