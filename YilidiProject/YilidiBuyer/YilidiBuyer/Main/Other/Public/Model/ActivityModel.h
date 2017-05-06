//
//  ActivityModel.h
//  YilidiBuyer
//
//  Created by yld on 16/8/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityModel : BaseModel

@property (nonatomic,copy)NSString *activityId;

@property (nonatomic,copy)NSString *activityName;

@property (nonatomic,copy)NSString *activityBeginTime;

@property (nonatomic,copy)NSString *activityEndTime;

@property (nonatomic,assign)NSInteger activityType;

@property (nonatomic,copy)NSString *activityTypeName;

@end

@interface ActivityModel (objectShopCartGoodsActivity)

+ (NSArray *)objectShopCartGoodsActivitys:(NSArray *)goodsActivities;

@end
