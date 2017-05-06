//
//  KJDarlingCommentVC.h
//  jingGang
//
//  Created by 张康健 on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJDarlingCommentVC : UIViewController
//订单ID
@property (nonatomic, copy)NSNumber *orderID;

//订单对应的商品数组
@property (nonatomic, copy)NSArray *goodsInfos;

@end
