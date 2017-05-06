//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsInformationInformationClassResponse.h"

@implementation SnsInformationInformationClassResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"informationClasses":@"informationClasses"
             };
}

+(NSValueTransformer *) informationClassesTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[InformationClassBO class]];
}
@end
