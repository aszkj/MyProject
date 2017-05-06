//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupInfo.h"

@implementation GroupInfo
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"groupSn":@"groupSn",
			@"refundReasion":@"refundReasion",
			@"status":@"status"
             };
}

@end
