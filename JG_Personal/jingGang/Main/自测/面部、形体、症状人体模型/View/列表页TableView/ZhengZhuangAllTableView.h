//
//  ZhengZhuangAllTableView.h
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZhengZhuangCureTable;

typedef void(^ClickZhengZhuangItemBlock)(long ID);

@interface ZhengZhuangAllTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *data;

@property (nonatomic,assign)BOOL isFaceClickTable;

@property (nonatomic,strong)NSMutableArray *cellHeightArr;

@property (nonatomic,strong)NSDictionary *dataDic;

@property (nonatomic,strong)ZhengZhuangCureTable *cureTable;

@property (nonatomic,copy)ClickZhengZhuangItemBlock clickZhengZhuangItemBlock;

@end
