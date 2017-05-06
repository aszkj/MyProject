//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ArticleBO.h"

@implementation ArticleBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"addTime":@"addTime",
			@"title":@"title",
			@"content":@"content",
			@"articleClassName":@"articleClassName"
             };
}

@end
