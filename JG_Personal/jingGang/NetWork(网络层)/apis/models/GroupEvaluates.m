//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupEvaluates.h"

@implementation GroupEvaluates
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"orderId":@"orderId",
			@"content":@"content",
			@"replyContent":@"replyContent",
			@"photoUrls":@"photoUrls",
			@"evaluateTime":@"evaluateTime",
			@"replyTime":@"replyTime",
			@"status":@"status",
			@"goodsName":@"goodsName",
			@"nickName":@"nickName",
			@"avatarUrl":@"avatarUrl",
			@"score":@"score"
             };
}

@end
