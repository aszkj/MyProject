//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersAllResponse.h"

@implementation UsersAllResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"users":@"users"
             };
}

+(NSValueTransformer *) usersTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[User class]];
}
@end
