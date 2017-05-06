//
//  PayOrderViewController.h
//  jingGang
//
//  Created by thinker on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineEnum.h"

@interface PayOrderViewController : UIViewController
@property (nonatomic) NSNumber *orderID;
@property (nonatomic) NSString *orderNumber;
@property (nonatomic) double userMoneyPaymet;
@property (nonatomic) double totalPrice;

@property (nonatomic, assign)JingGangPay jingGangPay;

@end
