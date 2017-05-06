//
//  TableViewModel.h
//  Merchants_JingGang
//
//  Created by ray on 15/9/15.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_ViewModel.h"

@interface XKO_TableViewModel : XKO_ViewModel

@property (nonatomic) NSArray *dataSource;
@property (nonatomic) NSNumber *pageNum;
@property (nonatomic) NSNumber *pageSize;
@property (nonatomic) NSNumber *optype;
@property (nonatomic) RACCommand *footerRefreshCommand;
@property (nonatomic) RACCommand *headerRefreshCommand;
@property (nonatomic) BOOL isNoMoreData;
@property (nonatomic) SEL footerSelector;
@property (nonatomic) SEL headerSelector;

- (void)addNewData:(NSArray *)newArray;

@end
