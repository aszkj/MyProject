//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ComputeOrderBO.h"

@implementation ComputeOrderBO
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"totalIntegral":@"totalIntegral",
			@"totalTransportFee":@"totalTransportFee",
			@"userIntegral":@"userIntegral"
             };
}

@end
