//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SnsCheckListResponse.h"

@implementation SnsCheckListResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"checkGruops":@"checkGruops",
			@"totalCount":@"totalCount"
             };
}

+(NSValueTransformer *) checkGruopsTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CheckGroup class]];
}
@end
