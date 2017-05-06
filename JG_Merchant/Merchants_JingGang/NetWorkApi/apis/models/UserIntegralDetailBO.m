//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UserIntegralDetailBO.h"

@implementation UserIntegralDetailBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"type":@"type",
			@"addtime":@"addtime",
			@"integral":@"integral"
             };
}

@end
