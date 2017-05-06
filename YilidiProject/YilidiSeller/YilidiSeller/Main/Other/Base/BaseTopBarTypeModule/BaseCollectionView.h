//
//  BaseCollectionView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopbarTypeTableDataLogicModule.h"
#import "NodataLogicModule.h"
@interface BaseCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

/**
 处理数据逻辑模块
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
 collection分页的时候请求分页数据后调用
 */
-(void)configureCollectionAfterRequestPagingData:(NSArray *)pageDatas;
/**
 collection不分页的时候请求数据后调用
 */
-(void)configureCollectionAfterRequestTotalData:(NSArray *)tatalDatas;



@end
