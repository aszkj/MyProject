//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "SysTrans.h"

@implementation SysTrans
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"tanBos":@"tanBos"
             };
}

+(NSValueTransformer *) tanBosTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[Trans class]];
}
@end
