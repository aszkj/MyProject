//
//  OrderDetailController.h
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailController : UIViewController

//主订单id
@property (nonatomic,strong)NSNumber *orderID;

@property (nonatomic, strong)NSArray *goodsInfo;

@end
