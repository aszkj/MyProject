//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorProfitList.h"

@implementation OperatorProfitList
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"storeName":@"storeName",
			@"rebateAmount":@"rebateAmount",
			@"rebateType":@"rebateType",
			@"createTime":@"createTime",
			@"rebateTypeName":@"rebateTypeName"
             };
}

@end
