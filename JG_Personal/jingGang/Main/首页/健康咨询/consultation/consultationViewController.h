//
//  consultationViewController.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/25.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//


#import "VApiManager.h"
#import "AccessToken.h"
#import "JGBaseViewController.h"

@interface consultationViewController : JGBaseViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, assign)NSInteger   btn_tag;

@property (nonatomic, retain)NSMutableArray   *left_array;
@property (nonatomic, retain)NSMutableArray   *right_array;

//从测试题哪里进去
@property (nonatomic,assign)BOOL comminFromSelfTest;


@end
