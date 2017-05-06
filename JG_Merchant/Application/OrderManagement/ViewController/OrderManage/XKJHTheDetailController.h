//
//  XKJHTheDetailController.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OnlineServiceRefundType,           //线上服务退款记录
    OnlineServiceIncomeDetailType,     //线上服务收入明细
    OfflineSwipeCardDetailType,        //线下刷卡明细
} TheDetailType; //明细控制器类型

@interface XKJHTheDetailController : UIViewController

//明细类型
@property (nonatomic, assign)TheDetailType theDetailType;

@end
