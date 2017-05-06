//
//  WIntegralListTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListBO.h"


@interface WIntegralListTableViewCell : UITableViewCell

/**
 *  每个cell的数据
 */
@property (nonatomic, copy)OrderListBO *data;


/**
 *  取消事件
 */
@property (nonatomic, copy) void (^cancelAction)(void);
/**
 *  确定收货
 */
@property (nonatomic, copy) void (^certainAction)(void);
/**
 *  付款
 */
@property (nonatomic, copy) void (^payAction)(void);
/**
 *  点击积分商品
 */
@property (nonatomic, copy) void (^shopAction)(NSDictionary *dict);



@end
