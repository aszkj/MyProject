//
//  AppInitResponse.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UsersInvitationExtendResponse.h"

@implementation UsersInvitationExtendResponse
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"errorCode":@"code",
             @"msg":@"msg",
             @"subCode":@"sub_code",
             @"subMsg":@"sub_msg",
			@"apiId":@"id",
			@"isPraise":@"isPraise",
			@"isFavorites":@"isFavorites",
			@"reportList":@"reportList",
			@"flag":@"flag",
			@"foodClassList":@"foodClassList"
             };
}

+(NSValueTransformer *) foodClassListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[FoodClass class]];
}
@end
