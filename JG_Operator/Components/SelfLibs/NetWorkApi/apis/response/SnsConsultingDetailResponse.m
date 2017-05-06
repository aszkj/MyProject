//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsConsultingDetailResponse.h"

@implementation SnsConsultingDetailResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"consultingBO":@"consultingBO"
             };
}

+(NSValueTransformer *) consultingBOTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ConsultingBO class]];
}
@end
