//
//  BaseTabbarTypeTableView.h
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopbarTypeTableDataLogicModule.h"
#import "NodataLogicModule.h"
@interface BaseTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataLogicModule:(TopbarTypeTableDataLogicModule *)dataLogicModule;

/**
 表处理数据逻辑模块
 */
@property (nonatomic, strong)TopbarTypeTableDataLogicModule *dataLogicModule;
/**
 没有数据逻辑模块
 */
@property (nonatomic, strong)NodataLogicModule *noDataLogicModule;
/**
 设置头自动刷新
 */
-(void)headerAutoRreshRequestBlock:(RequestDataBlock)headerAutoRequestBlock;
/**
 设置头下拉刷新
 */
-(void)headerRreshRequestBlock:(RequestDataBlock)headerRequestBlock;
/**
 设置尾部上拉加载更多
 */
-(void)footerRreshRequestBlock:(RequestDataBlock)footerRequestBlock;
/**
 表分页的时候请求数据后调用
 */
-(void)configureTableAfterRequestPagingData:(NSArray *)modelDatas;
/**
 表不分页的时候请求数据后调用
 */
-(void)configureTableAfterRequestTotalData:(NSArray *)tatalDatas;

#pragma mark - nodata

@end
