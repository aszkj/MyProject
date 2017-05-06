//
//  ConfigureDataSource.h
//  TinyTableView
//
//  Created by dengxf on 15/11/12.
//  Copyright © 2015年 dengxf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ConfigureDataCellBlock)(id cell, id item);

@interface ConfigureDataSource : NSObject<UITableViewDataSource>

/**
 *  初始化TableViewDataSources
 *
 *  @param anItems             列表的所有数据
 *  @param anClass             cell的类
 *  @param aCellIdentifier     cellId
 *  @param aConfigureCellBlock 配置cell的block
 *
 *  @return TableViewDataSources
 */
- (id)initWithItems:(NSArray *)items
          cellClass:(Class)Class
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(ConfigureDataCellBlock)configureCellBlock ;

/**
 *  返回某一行的数据源
 *
 *  @param indexPath cell的indexPath
 *
 *  @return 返回某一行的数据源
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
