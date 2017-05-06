//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopExpressCompanyListResponse.h"

@implementation ShopExpressCompanyListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"list":@"list"
             };
}

+(NSValueTransformer *) listTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ExpressCompany class]];
}
@end
