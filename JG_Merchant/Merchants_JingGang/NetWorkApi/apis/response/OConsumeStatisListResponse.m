//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "OConsumeStatisListResponse.h"

@implementation OConsumeStatisListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"memberList":@"memberList",
			@"orderOnlineList":@"orderOnlineList",
			@"voucherList":@"voucherList",
			@"voucherDetails":@"voucherDetails",
			@"consumeStatis":@"consumeStatis",
			@"payCartLineList":@"payCartLineList"
             };
}

+(NSValueTransformer *) memberListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Member class]];
}
+(NSValueTransformer *) orderOnlineListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[OrderOnLine class]];
}
+(NSValueTransformer *) voucherListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Voucher class]];
}
+(NSValueTransformer *) voucherDetailsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[VoucherDetails class]];
}
+(NSValueTransformer *) consumeStatisTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ConsumeStatis class]];
}
+(NSValueTransformer *) payCartLineListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PayCartLineDetails class]];
}
@end
