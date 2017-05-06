//
//  CustomTabBar.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// tab index
typedef enum
{
    UXinTabIndex_Dial        = 0, //
    UXinTabIndex_LocalAddressBook  = 1, //
    UXinTabIndex_IM          = 2, //
    UXinTabIndex_Wallet      = 3, //
    UXinTabIndex_None             // 其它
}UXinTabIndex;

// 红点提示类型
typedef enum
{
    UXinTabTipsType_Number     = 0, // 数字
    UXinTabTipsType_RedPoint        // 红点
}UXinTabTipsType;

// Label默认字体颜色
#define Label_Normal_Color [UIColor colorWithRed:146.f/255.0f green:146.f/255.0f blue:146.f/255.0f alpha:1.0f]

// 自定义TabBar
@interface CustomTabBar : UITabBarController <UITabBarControllerDelegate>

// instance
+ (CustomTabBar *) instance;


// 设置Tab选择项
// nIndex : Tab 索引
- (void) setSelectedTab:(int) nIndex;

@end