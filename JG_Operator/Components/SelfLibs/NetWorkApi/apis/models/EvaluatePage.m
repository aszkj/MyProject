//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "EvaluatePage.h"

@implementation EvaluatePage
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"descriptionEvaluate":@"descriptionEvaluate",
			@"evaluateBuyerVal":@"evaluateBuyerVal",
			@"evaluatePhotos":@"evaluatePhotos",
			@"evaluateStatus":@"evaluateStatus",
			@"goodsNum":@"goodsNum",
			@"serviceEvaluate":@"serviceEvaluate",
			@"shipEvaluate":@"shipEvaluate",
			@"ofId":@"ofId",
			@"replyStatus":@"replyStatus",
			@"addevaStatus":@"addevaStatus",
			@"追评时间":@"追评时间",
			@"evaluateAdminInfo":@"evaluateAdminInfo",
			@"evaluateInfo":@"evaluateInfo",
			@"reply":@"reply",
			@"addevaInfo":@"addevaInfo",
			@"addevaPhotos":@"addevaPhotos",
			@"nickName":@"nickName",
			@"goodsName":@"goodsName",
			@"storeName":@"storeName",
			@"goodsSpec":@"goodsSpec",
			@"goodsMainPhotoPath":@"goodsMainPhotoPath",
			@"addTime":@"addTime"
             };
}

@end
