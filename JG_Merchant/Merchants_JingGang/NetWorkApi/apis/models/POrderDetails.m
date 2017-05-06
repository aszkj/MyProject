//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "POrderDetails.h"

@implementation POrderDetails
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"orderId":@"orderId",
			@"groupSn":@"groupSn",
			@"mobile":@"mobile",
			@"paymentMark":@"paymentMark",
			@"payTime":@"payTime",
			@"totalPrice":@"totalPrice",
			@"endTime":@"endTime",
			@"userNickname":@"userNickname",
			@"storeAddress":@"storeAddress",
			@"storeName":@"storeName",
			@"storeTelephone":@"storeTelephone",
			@"serviceList":@"serviceList",
			@"orderStatus":@"orderStatus",
			@"localGroupName":@"localGroupName",
			@"distance":@"distance",
			@"storeLat":@"storeLat",
			@"storeLon":@"storeLon",
			@"orderType":@"orderType",
			@"groupId":@"groupId"
             };
}

+(NSValueTransformer *) serviceListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Pservice class]];
}
@end
