//
//  mydevieseViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "devicesChildViewController.h"
@interface mydevieseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy)NSString       * keyStr;
@property (nonatomic, retain)NSMutableArray * devArray;

@property (nonatomic, retain)devicesChildViewController * deviceChindVC;


@property BOOL isComminFromSelfVC;

@property BOOL isComminFromTheRing;


@end
