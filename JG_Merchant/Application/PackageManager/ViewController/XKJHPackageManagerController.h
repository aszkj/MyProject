//
//  XKJHPackageManagerController.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHBaseController.h"
@class XKJHSlideSwitchView;
@class XKJHAddShelfController;
@class XKJHOffShelfController;
@class XKJHViolateShelfController;

typedef enum : NSUInteger {
    
    TicketManagerPackageType = 1, //套餐券
    TicketManagerCashType = 2,          //现金券
    
} TicketManagerType; //明细控制器类型



@interface XKJHPackageManagerController : XKJHBaseController

@property (nonatomic, assign) TicketManagerType requestType;
@property (nonatomic, strong) XKJHSlideSwitchView *slideSwitchView;
@property (nonatomic, strong) XKJHAddShelfController *addShelfController;
@property (nonatomic, strong) XKJHOffShelfController *offShelfController;
@property (nonatomic, strong) XKJHViolateShelfController *violateShelfController;

@end
