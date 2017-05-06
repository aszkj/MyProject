//
//  someTestViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/6/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface someTestViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)NSString        *keyStr;
@property (nonatomic, copy)NSString        *img_name;//顶部背景图片
@property (nonatomic, copy)NSString        *img_name2;//顶部标示图标
@property (nonatomic, retain)NSMutableArray *name_array;


//大任务编号
@property (nonatomic,assign)NSInteger bigTaskNum;

@end
