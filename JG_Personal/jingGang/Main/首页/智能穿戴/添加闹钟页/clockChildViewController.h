//
//  clockChildViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clockChildViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, copy)NSString         *name_str;
@property (nonatomic, retain)NSMutableArray *clock_num_array;

+ (clockChildViewController *) instance;

@end
