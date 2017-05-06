//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "MyselfGroupOrder.h"

@implementation MyselfGroupOrder
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"groupAccPath":@"groupAccPath",
			@"ggName":@"ggName",
			@"totalPrice":@"totalPrice",
			@"status":@"status",
			@"orderStatus":@"orderStatus",
			@"goodsCount":@"goodsCount",
			@"groupInfo":@"groupInfo",
			@"service":@"service"
             };
}

+(NSValueTransformer *) serviceTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupService class]];
}
@end
