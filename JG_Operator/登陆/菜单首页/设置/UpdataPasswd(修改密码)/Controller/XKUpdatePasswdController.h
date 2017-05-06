//
//  XKUpdatePasswdController.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTopbarTypeController.h"

typedef enum : NSUInteger {
    UpdatePasswd,
    UpdateRefundPasswd,
} UpdatePasswdType;

@interface XKUpdatePasswdController : BaseTopbarTypeController

@property (nonatomic, assign)UpdatePasswdType updatePasswdType;

@end
