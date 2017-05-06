//
//  OrderConfirmViewController.h
//  jingGang
//
//  Created by thinker on 15/8/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "XK_ViewController.h"

@interface OrderConfirmViewController : XK_ViewController

/**
 *  购物车商品, 格式为购物车id ","分隔 例：12,13
 */
@property (nonatomic, copy) NSString *gcIds;

@property (nonatomic, assign)BOOL isComeFromBuyNow;

#pragma mark - 立即购买进去需要参数
@property (nonatomic, copy) NSNumber *goodsId;
@property (nonatomic, strong)NSNumber *goodsCount;
//商品属性
@property (nonatomic, copy)NSString *goodsGsp;

@end
