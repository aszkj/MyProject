//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersConsultingListResponse.h"

@implementation UsersConsultingListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"consultingResult":@"consultingResult",
			@"totalCount":@"totalCount"
             };
}

+(NSValueTransformer *) consultingResultTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[UserConsultingListBO class]];
}
@end
