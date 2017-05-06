//
//  salesReturnVC.h
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplySalesReturnVC : UIViewController

/**
 *  订单ID
 */
@property (nonatomic) long orderID;
/**
 *  商品ID
 */
@property (nonatomic) long goodsID;
/**
 *  商品sku ids
 */
@property (nonatomic) NSString *goodsGspIds;


- (instancetype)initWithResponse:(id)response;

@end
