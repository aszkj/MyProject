//
//  KJGoodKindSelectTableView.h
//  jingGang
//
//  Created by 张康健 on 15/8/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJGoodKindSelectTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)NSDictionary *cationPropertyDic;

//库存
@property (nonatomic, assign)NSInteger goodsStockCount;

@end
