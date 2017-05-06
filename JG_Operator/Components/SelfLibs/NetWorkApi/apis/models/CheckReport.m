//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CheckReport.h"

@implementation CheckReport
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"resultname":@"resultname",
			@"createby":@"createby",
			@"createtime":@"createtime",
			@"hospital":@"hospital",
			@"status":@"status",
			@"result":@"result",
			@"rightCount":@"rightCount",
			@"wrongCount":@"wrongCount",
			@"detailsList":@"detailsList",
			@"checkTime":@"checkTime"
             };
}

+(NSValueTransformer *) detailsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ResultDetails class]];
}
@end
