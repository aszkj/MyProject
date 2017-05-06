//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "AlipayPaymet.h"

@implementation AlipayPaymet
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"safeKey":@"safeKey",
			@"sellerEmail":@"sellerEmail",
			@"partner":@"partner",
			@"appPrivateKey":@"appPrivateKey",
			@"appPublicKey":@"appPublicKey"
             };
}

@end
