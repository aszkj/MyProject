//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CloudBuyerMoneyPasswordValidateResponse.h"

@implementation CloudBuyerMoneyPasswordValidateResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"cloudPredepositCash":@"cloudPredepositCash",
			@"loginName":@"loginName",
			@"ret":@"ret"
             };
}

+(NSValueTransformer *) cloudPredepositCashTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CloudForm class]];
}
@end
