//
//  KJOrderDetailResultTableView.h
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJOrderDetailResultTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy)NSArray *resultData;

@end
