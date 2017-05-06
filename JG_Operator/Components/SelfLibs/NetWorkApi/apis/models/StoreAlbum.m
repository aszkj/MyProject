//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "StoreAlbum.h"

@implementation StoreAlbum
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"path":@"path",
			@"name":@"name"
             };
}

@end
