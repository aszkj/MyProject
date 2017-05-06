//
//  Order.h
//  XIXINProject
//
//  Created by apple_02 on 15/4/27.
//  Copyright (c) 2015年 ciwong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, assign) float price;
@property (nonatomic, strong) NSString *subject;      //商品标题
@property (nonatomic, strong) NSString *body;         //商品描述
@property (nonatomic, strong) NSString *orderId;      //订单ID

@end
