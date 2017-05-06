//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OperatorInvitationCodeGetResponse.h"

@implementation OperatorInvitationCodeGetResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"operatorInfo":@"operatorInfo",
			@"cashMoneyDetailsBOs":@"cashMoneyDetailsBOs",
			@"memberList":@"memberList",
			@"operatorList":@"operatorList",
			@"invitationCode":@"invitationCode",
			@"operatorRebateList":@"operatorRebateList",
			@"operatorpProfitList":@"operatorpProfitList",
			@"profitTotal":@"profitTotal",
			@"operatorRelation":@"operatorRelation",
			@"operatorRegisterList":@"operatorRegisterList",
			@"expectProfit":@"expectProfit",
			@"expectProfitTotal":@"expectProfitTotal"
             };
}

+(NSValueTransformer *) operatorInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OperatorInfo class]];
}
+(NSValueTransformer *) cashMoneyDetailsBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CashMoneyDetails class]];
}
+(NSValueTransformer *) memberListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OperatorMember class]];
}
+(NSValueTransformer *) operatorListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OperatorProfitList class]];
}
+(NSValueTransformer *) operatorRebateListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OperatorManagement class]];
}
+(NSValueTransformer *) operatorpProfitListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OperatorProfit class]];
}
+(NSValueTransformer *) operatorRelationTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OperatorRelationList class]];
}
+(NSValueTransformer *) operatorRegisterListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OperatorRegisterUserList class]];
}
+(NSValueTransformer *) expectProfitTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OperatorProfitList class]];
}
@end
