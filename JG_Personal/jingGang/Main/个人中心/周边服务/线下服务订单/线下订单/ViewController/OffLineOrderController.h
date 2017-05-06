//
//  OffLineOrderController.h
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PersonalOrderOnLineType = 1, // 个人线上订单
    PersonalOrderOffLineType = 2, // 个人线下订单
} PersonalOrderType; // 个人订单类型

@interface OffLineOrderController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, assign) PersonalOrderType orderType;

@end
