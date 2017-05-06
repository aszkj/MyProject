//
//  JGActivityHotSaleApiBO.h
//  jingGang
//
//  Created by dengxf on 15/12/10.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGActivityHotSaleApiBO : NSObject

/**
 *  促销活动id
 */
@property (assign, nonatomic) long aid;

/**
 *  促销活动名称
 */
@property (copy , nonatomic) NSString *hotName;

/**
 * 促销活动首页图片
 */
@property (copy , nonatomic) NSString *firstImage;

/**
 * 促销活动头部图片
 */
@property (copy , nonatomic) NSString *headImage;

/**
 * 促销活动底部图片
 */
@property (copy , nonatomic) NSString *footImage;

/**
 *  结束时间
 */
@property (copy , nonatomic) NSString *endTime;

/**
 *  开始时间
 */
@property (copy , nonatomic) NSString *startTime;

- (instancetype)initWithResponseDic:(NSDictionary *)dic;

@end
