//
//  XKJHMapViewController.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/11.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKJHMapViewController : UIViewController


#pragma mark - ---------------大头针信息-------------
//商铺的地理位置信息
@property (nonatomic, copy) NSString *shopAddress;
//纬度
@property (nonatomic, assign) CGFloat latitude;
//经度
@property (nonatomic, assign) CGFloat longitude;



@end
