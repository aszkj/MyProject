//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsRecommendListResponse.h"

@implementation SnsRecommendListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"advList":@"advList"
             };
}

+(NSValueTransformer *) advListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PositionAdvertBO class]];
}
@end
