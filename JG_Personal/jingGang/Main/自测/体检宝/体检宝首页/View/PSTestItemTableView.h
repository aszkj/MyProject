//
//  PSTestItemTableView.h
//  jingGang
//
//  Created by 张康健 on 15/7/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemClickBlock)(NSIndexPath *clickIndexPath);

@interface PSTestItemTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *data;

@property (nonatomic,copy)ItemClickBlock itemClickBlock;

@end
