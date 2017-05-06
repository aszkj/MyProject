//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsBodyListResponse.h"

@implementation SnsBodyListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"informationClasses":@"informationClasses",
			@"boyList":@"boyList"
             };
}

+(NSValueTransformer *) informationClassesTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[InformationClassBO class]];
}
+(NSValueTransformer *) boyListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[HumanBody class]];
}
@end
