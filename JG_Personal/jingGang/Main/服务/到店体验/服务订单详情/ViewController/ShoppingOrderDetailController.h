//
//  ShoppingOrderDetailController.h
//  jingGang
//
//  Created by 鹏 朱 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DetailControllerType) {
    ControllerServicePayType  // 服务支付类型
};

@interface ShoppingOrderDetailController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign) long orderId;

- (instancetype)initWithStatus:(NSInteger)status;

@property (assign, nonatomic) DetailControllerType controllerType;

@end
