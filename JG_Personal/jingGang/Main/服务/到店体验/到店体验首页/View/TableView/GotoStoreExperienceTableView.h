//
//  GotoStoreExperienceTableView.h
//  jingGang
//
//  Created by 张康健 on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickItemBlock)(NSNumber *indexID);

typedef enum : NSUInteger {
    PromoteRecommendTableType,
    GoodStoreRecommendTableType,
    NearestTableType,
} GotoStoreTableType;

@interface GotoStoreExperienceTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign)GotoStoreTableType gotoStoreTableType;

@property (nonatomic, strong)ClickItemBlock clickItemBlock;

@property (nonatomic, copy)NSArray *dataArr;

@end
