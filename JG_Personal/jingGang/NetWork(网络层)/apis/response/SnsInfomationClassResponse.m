//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsInfomationClassResponse.h"

@implementation SnsInfomationClassResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"invitationClasses":@"invitationClasses"
             };
}

+(NSValueTransformer *) invitationClassesTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[InvitationClassBO class]];
}
@end
