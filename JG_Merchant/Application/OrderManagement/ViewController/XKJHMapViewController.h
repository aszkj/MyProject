//
//  XKJHMapViewController.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/11.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKJHMapViewController : UIViewController

//选过大头针的信息
@property (nonatomic, copy) NSString *selectAddress;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

//省份、市、区地址
@property (nonatomic, strong) NSString *address;

//点击商户所在地回调
@property (nonatomic, copy) void (^addressBlock)(NSString *address,CGFloat latitude, CGFloat longitude);

@end
