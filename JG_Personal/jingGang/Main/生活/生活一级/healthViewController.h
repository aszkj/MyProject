//
//  healthViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//


#import "MJRefresh.h"
#import "JGBaseViewController.h"


@interface healthViewController : JGBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain)NSMutableArray * head_arr;//顶部图片数组

@end
