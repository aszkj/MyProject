//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "ShopEvaluate.h"

@implementation ShopEvaluate
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"addTime":@"addTime",
			@"descriptionEvaluate":@"descriptionEvaluate",
			@"evaluateBuyerVal":@"evaluateBuyerVal",
			@"evaluatePhotos":@"evaluatePhotos",
			@"evaluateStatus":@"evaluateStatus",
			@"goodsPrice":@"goodsPrice",
			@"serviceEvaluate":@"serviceEvaluate",
			@"shipEvaluate":@"shipEvaluate",
			@"addevaTime":@"addevaTime",
			@"evaluateAdminInfo":@"evaluateAdminInfo",
			@"evaluateInfo":@"evaluateInfo",
			@"goodsSpec":@"goodsSpec",
			@"reply":@"reply",
			@"addevaInfo":@"addevaInfo",
			@"addevaPhotos":@"addevaPhotos",
			@"nickName":@"nickName",
			@"goodsName":@"goodsName",
			@"storeName":@"storeName",
			@"headImgPath":@"headImgPath"
             };
}

@end
