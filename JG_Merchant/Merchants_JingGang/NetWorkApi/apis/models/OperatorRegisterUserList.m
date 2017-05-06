//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorRegisterUserList.h"

@implementation OperatorRegisterUserList
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"nickname":@"nickname",
			@"areaName":@"areaName",
			@"sellerNickName":@"sellerNickName",
			@"operatorName":@"operatorName",
			@"operatorCode":@"operatorCode",
			@"createTime":@"createTime",
			@"storeName":@"storeName"
             };
}

@end
