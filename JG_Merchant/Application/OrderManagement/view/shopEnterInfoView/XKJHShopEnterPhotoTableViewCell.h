//
//  XKJHShopEnterPhotoTableViewCell.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XKJHShopEnterInfoModel.h"

@interface XKJHShopEnterPhotoTableViewCell : UITableViewCell

@property (nonatomic, strong) XKJHShopEnterInfoModel *model;
@property (nonatomic, copy) void (^reloadData)(void);


@end
