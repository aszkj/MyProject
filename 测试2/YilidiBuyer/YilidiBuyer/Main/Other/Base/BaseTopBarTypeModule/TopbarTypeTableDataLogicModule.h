//
//  TopbarTypeTableDataLogicModule.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^RequestDataBlock)(void);
@interface TopbarTypeTableDataLogicModule : NSObject

//从哪一页开始请求
@property (nonatomic, assign)NSInteger requestFromPage;

//一页请求多少
@property (nonatomic, assign)NSInteger requestPageSize;

//总页数
@property (nonatomic, assign)NSInteger totalPage;


//当前数据源
@property (atomic, strong)NSMutableArray *currentDataModelArr;

//是否是头部自动刷新，刷新有三种，头部自动刷新，下拉头部刷新，上拉刷新
@property (nonatomic, assign)BOOL isAutoHeaderFresh;

//是否已经自动刷新了，
@property (nonatomic, assign)BOOL isFinishedHeaderAutoFresh;

//是否是要分页
@property (nonatomic,assign)BOOL isRequestByPage;


@end
