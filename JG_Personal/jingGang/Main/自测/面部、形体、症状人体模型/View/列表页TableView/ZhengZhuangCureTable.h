//
//  ZhengZhuangCureTable.h
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TestResultBlock)(long ID);
typedef void(^FoodCulateBlock)(NSDictionary *culResult);

@interface ZhengZhuangCureTable : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *data;

@property (nonatomic,copy)TestResultBlock testBlock;
@property (nonatomic,copy)FoodCulateBlock foodCulateBlock;

@property BOOL isFaceClick;

@end
