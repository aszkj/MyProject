//
//  ActivityModel.m
//  YilidiBuyer
//
//  Created by yld on 16/8/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

@end


@implementation ActivityModel (objectShopCartGoodsActivity)

+ (NSArray *)objectShopCartGoodsActivitys:(NSArray *)goodsActivities {

    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:goodsActivities.count];
    for (NSDictionary *dic in goodsActivities) {
        ActivityModel *model = [[ActivityModel alloc] init];
        model.activityId = dic[@"actId"];
        model.activityName = dic[@"actName"];
        model.activityType = [dic[@"actType"] integerValue];
        model.activityTypeName = dic[@"actTypeName"];
        [tempArr addObject:model];
    }
    return [tempArr copy];
}

@end
