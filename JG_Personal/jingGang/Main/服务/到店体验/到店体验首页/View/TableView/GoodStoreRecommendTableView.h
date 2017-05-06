//
//  GoodStoreRecommendTableView.h
//  jingGang
//
//  Created by 张康健 on 15/10/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GoodStoreCellHeight 98
@class GoodStoreRecommendTableView;
typedef void(^GoodStoreRequestBlcok)(CGFloat tableHeight, GoodStoreRecommendTableView *tableView);
@interface GoodStoreRecommendTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)NSArray *dataArr;


//请求推荐位
-(void)requestWithStoreCode:(NSString *)storeCode result:(GoodStoreRequestBlcok)resultBlock;

@end
