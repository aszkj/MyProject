//
//  XKJHShopEnterHeaderView.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKJHShopEnterInfoModel.h"

@interface XKJHShopEnterHeaderView : UIView


@property (nonatomic, copy) XKJHShopEnterInfoModel *model;
//点击照相按钮回调
@property (nonatomic, copy) void(^photoBlock)(void);

//@property (nonatomic, assign) BOOL isXian;

@end

