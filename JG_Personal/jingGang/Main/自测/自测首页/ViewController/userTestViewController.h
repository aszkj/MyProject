//
//  userTestViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "MJRefresh.h"
#import "JGBaseViewController.h"

@interface userTestViewController : JGBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain)NSMutableArray   *news_array;


@end
