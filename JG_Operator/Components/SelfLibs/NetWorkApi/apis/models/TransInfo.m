//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "TransInfo.h"

@implementation TransInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"expressEompanyName":@"expressEompanyName",
			@"expressShipCode":@"expressShipCode",
			@"data":@"data",
			@"expressName":@"expressName"
             };
}

+(NSValueTransformer *) dataTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[TransContent class]];
}
@end
