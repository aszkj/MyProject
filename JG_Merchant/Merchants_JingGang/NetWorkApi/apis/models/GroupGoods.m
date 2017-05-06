//
//  Role.m
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-14.
//  Copyright (c) 2014年 duocai. All rights reserved.
//

#import "GroupGoods.h"

@implementation GroupGoods
+(NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
			@"apiId":@"id",
			@"ggName":@"ggName",
			@"costPrice":@"costPrice",
			@"ggRebate":@"ggRebate",
			@"groupPrice":@"groupPrice",
			@"ggStatus":@"ggStatus",
			@"groupAccPath":@"groupAccPath",
			@"groupDesc":@"groupDesc",
			@"beginTime":@"beginTime",
			@"endTime":@"endTime",
			@"selledCount":@"selledCount",
			@"groupNotice":@"groupNotice",
			@"nickName":@"nickName",
			@"mobile":@"mobile",
			@"groupSn":@"groupSn",
			@"status":@"status",
			@"storeName":@"storeName",
			@"storeAddress":@"storeAddress",
			@"likeGoodsList":@"likeGoodsList",
			@"distance":@"distance",
			@"licenseCTelephone":@"licenseCTelephone",
			@"storeLat":@"storeLat",
			@"storeLon":@"storeLon"
             };
}

+(NSValueTransformer *) likeGoodsListTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GroupGoods class]];
}
@end
