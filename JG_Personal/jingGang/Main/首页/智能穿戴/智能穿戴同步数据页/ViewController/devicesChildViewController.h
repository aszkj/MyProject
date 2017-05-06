//
//  devicesChildViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBlock)();
@interface devicesChildViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign)NSInteger  view_tag;//主要控制睡眠界面
@property (nonatomic, copy)NSString     *img_name;
@property (nonatomic, retain)NSArray    *midel_name_array;
@property (nonatomic, retain)NSArray    *midel_array;

@property (nonatomic,copy)BackBlock backBlock;


//标志自己是通过pop呈现的
@property (nonatomic,assign)BOOL selfIsPopPresented;

@end
