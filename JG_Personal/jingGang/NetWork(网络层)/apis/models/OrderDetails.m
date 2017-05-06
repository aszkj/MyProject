//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OrderDetails.h"

@implementation OrderDetails
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"nickname":@"nickname",
			@"mobile":@"mobile",
			@"groupSn":@"groupSn",
			@"addTime":@"addTime",
			@"totalPrice":@"totalPrice",
			@"groupInfo":@"groupInfo",
			@"groupService":@"groupService",
			@"userNickname":@"userNickname",
			@"localGroupName":@"localGroupName",
			@"groupPrice":@"groupPrice",
			@"profitPrice":@"profitPrice",
			@"userId":@"userId",
			@"proportion":@"proportion"
             };
}

+(NSValueTransformer *) groupServiceTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupService class]];
}
@end
