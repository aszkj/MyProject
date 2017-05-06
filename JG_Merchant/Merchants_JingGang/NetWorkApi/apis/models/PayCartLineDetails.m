//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "PayCartLineDetails.h"

@implementation PayCartLineDetails
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"nickName":@"nickName",
			@"mobile":@"mobile"
             };
}

@end
