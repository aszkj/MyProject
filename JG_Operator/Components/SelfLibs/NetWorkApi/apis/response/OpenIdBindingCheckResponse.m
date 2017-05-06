//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OpenIdBindingCheckResponse.h"

@implementation OpenIdBindingCheckResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"customer":@"customer",
			@"integral":@"integral",
			@"availableBalance":@"availableBalance",
			@"balance":@"balance",
			@"storeBankInfo":@"storeBankInfo",
			@"operatorBankInfo":@"operatorBankInfo",
			@"userSign":@"userSign",
			@"bindingMobile":@"bindingMobile",
			@"isBinding":@"isBinding",
			@"bindingOpenId":@"bindingOpenId",
			@"documet":@"documet",
			@"articleList":@"articleList",
			@"opNoticesBOs":@"opNoticesBOs",
			@"articleBO":@"articleBO",
			@"noticesBO":@"noticesBO",
			@"articMarkleList":@"articMarkleList",
			@"articMarkleDetails":@"articMarkleDetails",
			@"ralationList":@"ralationList",
			@"relationCount":@"relationCount",
			@"isCloudPassword":@"isCloudPassword",
			@"mobile":@"mobile"
             };
}

+(NSValueTransformer *) customerTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserCustomer class]];
}
+(NSValueTransformer *) integralTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserIntegral class]];
}
+(NSValueTransformer *) storeBankInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[StoreBank class]];
}
+(NSValueTransformer *) operatorBankInfoTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OperatorBank class]];
}
+(NSValueTransformer *) userSignTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserSign class]];
}
+(NSValueTransformer *) documetTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserDocument class]];
}
+(NSValueTransformer *) articleListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ArticleBO class]];
}
+(NSValueTransformer *) opNoticesBOsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OpNotices class]];
}
+(NSValueTransformer *) articleBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ArticleBO class]];
}
+(NSValueTransformer *) noticesBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OpNotices class]];
}
+(NSValueTransformer *) articMarkleListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ArticleBO class]];
}
+(NSValueTransformer *) articMarkleDetailsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ArticleBO class]];
}
+(NSValueTransformer *) ralationListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Relation class]];
}
@end
