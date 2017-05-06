//
//  ConfigureDataSource.m
//  TinyTableView
//
//  Created by dengxf on 15/11/12.
//  Copyright © 2015年 dengxf. All rights reserved.
//

#import "ConfigureDataSource.h"

typedef NS_ENUM(NSUInteger, kTableViewType) {
    kTableViewStylePlain,
    kITableViewStyleGrouped,
    kTableViewStyleNul
};

@interface ConfigureDataSource()
/**
 *  数据源
 */
@property(nonatomic,strong) NSArray *items;

/**
 *  cellId
 */
@property(nonatomic,copy) NSString *cellIdentifier;

@property(nonatomic,strong) Class cellClass;

/**
 *
 */
@property(nonatomic,copy) ConfigureDataCellBlock configureCellBlock;

@property (assign, nonatomic) kTableViewType kTableViewType;

@end

@implementation ConfigureDataSource

/**
 *  初始化TableViewDataSources
 *
 *  @param anItems             列表的所有数据
 *  @param aCellIdentifier     cellId
 *  @param aConfigureCellBlock 配置cell的block
 *
 *  @return TableViewDataSources
 */
- (id)initWithItems:(NSArray *)items
          cellClass:(Class)Class
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(ConfigureDataCellBlock)configureCellBlock
{
    self = [super init];
    if (self) {
        self.items = items;
        self.kTableViewType = [self kTableViewTypeWithItmes:items];
        self.cellClass = Class;
        self.cellIdentifier = cellIdentifier;
        self.configureCellBlock = [configureCellBlock copy];
    }
    return self;
}

- (kTableViewType)kTableViewTypeWithItmes:(NSArray *)items {
    if (items) {
        if ([[items firstObject] isKindOfClass:[NSArray class]]) {
            return kITableViewStyleGrouped;
        }else {
            return kTableViewStylePlain;
        }
    }
    return kTableViewStyleNul;
}

/**
 *  返回某一行的数据源
 *
 *  @param indexPath cell的indexPath
 *
 *  @return 返回某一行的数据源
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.kTableViewType == kTableViewStylePlain) {
        return self.items[indexPath.row];
    }else if (self.kTableViewType == kITableViewStyleGrouped) {
        NSArray *items = self.items[indexPath.section] ;
        return items[indexPath.row];
    }
    return nil;
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.kTableViewType == kTableViewStylePlain) {
        return 1;
    }else if (self.kTableViewType == kITableViewStyleGrouped) {
        return self.items.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.kTableViewType == kTableViewStylePlain) {
        return self.items.count;
    }else if (self.kTableViewType == kITableViewStyleGrouped) {
        return [self.items[section] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[self.cellClass alloc] init];
        
    }
    
    id item = [self itemAtIndexPath:indexPath];
    
    self.configureCellBlock(cell,item);
    
    return cell;
}


@end
