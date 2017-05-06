//
//  XKJHShopEnterInfoTableViewCell.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKJHShopEnterInfoModel.h"

@interface XKJHShopEnterInfoTableViewCell : UITableViewCell

@property (nonatomic, copy) XKJHShopEnterInfoModel *model;


//选择回调 -- 主营和详细类目回调
@property (nonatomic, copy) void(^enterCategoryBlock)(NSString *title);
//地图回调 -- 商户所在地回调
@property (nonatomic, copy) void(^mapBlock)(void);
//点击右边地图图标
@property (nonatomic, copy) void(^mapPositionBlock)(void);
//开户行省市
@property (nonatomic, copy) void(^bankAreaBlock)(void);

@end
