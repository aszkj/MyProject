//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupOrderDetails.h"

@implementation GroupOrderDetails
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"orderId":@"orderId",
			@"addTime":@"addTime",
			@"nickName":@"nickName",
			@"mobile":@"mobile",
			@"serviceBO":@"serviceBO",
			@"groupInfo":@"groupInfo"
             };
}

+(NSValueTransformer *) serviceBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupService class]];
}
+(NSValueTransformer *) groupInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupInfo class]];
}
@end
