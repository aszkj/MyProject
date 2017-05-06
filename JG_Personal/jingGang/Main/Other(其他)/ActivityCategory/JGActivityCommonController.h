//
//  JGActivityCommonController.h
//  jingGang
//
//  Created by dengxf on 15/12/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JGActivityHotSaleApiBO.h"


@interface JGActivityCommonController : UIViewController

- (instancetype)initWithApiBO:(JGActivityHotSaleApiBO *)apiBO;

/**  活动的类型 */
//@property (assign, nonatomic) JGActivityType activityType;

@end
