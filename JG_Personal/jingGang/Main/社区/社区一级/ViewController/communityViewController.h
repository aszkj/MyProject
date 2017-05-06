//
//  communityViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "VApiManager.h"
#import "AccessToken.h"
#import "MJRefresh.h"
#import "JGBaseViewController.h"

@interface communityViewController : JGBaseViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
/**
 *  用户帖子数据
 */
@property (nonatomic, retain)NSMutableArray      *news_array;



@end
