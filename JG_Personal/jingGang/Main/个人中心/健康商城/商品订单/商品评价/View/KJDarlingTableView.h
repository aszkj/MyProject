//
//  KJDarlingTableView.h
//  jingGang
//
//  Created by 张康健 on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJDarlingTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy)NSMutableArray *commentModelArr;

@property (nonatomic,copy)NSArray *goodsArr;

@end
