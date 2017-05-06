//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "CheckGroup.h"

@implementation CheckGroup
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"thumbnail":@"thumbnail",
			@"groupTitle":@"groupTitle",
			@"summary":@"summary",
			@"content":@"content"
             };
}

@end
