//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupOrder.h"

@implementation GroupOrder
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"nickName":@"nickName",
			@"mobile":@"mobile",
			@"groupSn":@"groupSn",
			@"totalPrice":@"totalPrice",
			@"addTime":@"addTime",
			@"orderStatus":@"orderStatus",
			@"groupInfo":@"groupInfo",
			@"localReturnStatus":@"localReturnStatus",
			@"localGroupName":@"localGroupName",
			@"orderId":@"orderId",
			@"groupService":@"groupService",
			@"groupInfoBOs":@"groupInfoBOs",
			@"paymentMark":@"paymentMark"
             };
}

+(NSValueTransformer *) groupServiceTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupService class]];
}
+(NSValueTransformer *) groupInfoBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupInfo class]];
}
@end
