//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GoodsConsult.h"

@implementation GoodsConsult
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"addTime":@"addTime",
			@"consultUserId":@"consultUserId",
			@"consultUserName":@"consultUserName",
			@"replyTime":@"replyTime",
			@"replyUserName":@"replyUserName",
			@"satisfy":@"satisfy",
			@"storeName":@"storeName",
			@"unsatisfy":@"unsatisfy",
			@"whetherSelf":@"whetherSelf",
			@"consultContent":@"consultContent",
			@"consultReply":@"consultReply",
			@"goodsInfo":@"goodsInfo"
             };
}

@end
