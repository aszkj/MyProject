//
//  JGActivityDetailController.h
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGActivityHotSaleApiBO.h"
typedef NS_ENUM(NSUInteger, JGActivityType) {
    JGActivityDoubleDayType = 0  // 双12
};

/** 活动页面的详情界面 */
@interface JGActivityDetailController : UIViewController

- (instancetype)initWithApiBO:(JGActivityHotSaleApiBO *)apiBO;

/**  活动的类型 */
@property (assign, nonatomic) JGActivityType activityType;

@end
