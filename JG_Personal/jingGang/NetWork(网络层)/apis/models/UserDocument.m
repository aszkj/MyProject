//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "UserDocument.h"

@implementation UserDocument
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"mark":@"mark",
			@"title":@"title",
			@"content":@"content",
			@"htmlContent":@"htmlContent"
             };
}

@end
