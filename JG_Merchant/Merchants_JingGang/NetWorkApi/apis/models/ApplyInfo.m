//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ApplyInfo.h"

@implementation ApplyInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"storeStatus":@"storeStatus",
			@"isEepay":@"isEepay",
			@"failReseaon":@"failReseaon"
             };
}

@end
