//
//  AppInitResponse.h
//  VApiSDK_iOS
//
//  Created by duocai on 14-6-16.
//  Copyright (c) 2014年 duocai. All rights reserved.
//


#import "AbstractResponse.h"
#import "ActivityHotSaleApiBO.h"

@interface SalePromotionAdInfoResponse :  AbstractResponse
//促销活动信息
@property (nonatomic, readonly, copy) ActivityHotSaleApiBO *activityHotSaleApiBO;
@end
