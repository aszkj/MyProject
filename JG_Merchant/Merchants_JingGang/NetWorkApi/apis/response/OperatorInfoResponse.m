//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorInfoResponse.h"

@implementation OperatorInfoResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"operatorInfo":@"operatorInfo",
			@"cashMoneyDetailsBOs":@"cashMoneyDetailsBOs",
			@"memberList":@"memberList"
             };
}

+(NSValueTransformer *) operatorInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Operator class]];
}
+(NSValueTransformer *) cashMoneyDetailsBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CashMoneyDetails class]];
}
+(NSValueTransformer *) memberListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OperatorMember class]];
}
@end
