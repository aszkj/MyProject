//
//  TableViewModel.m
//  Merchants_JingGang
//
//  Created by ray on 15/9/15.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "TableViewModel.h"
#import "MerchantClient.h"

@implementation TableViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.footerSelector = @selector(takeListAddSignal);
        self.headerSelector = @selector(takeListResetSignal);
    }
    
    return self;
}

- (RACSignal *)shareDetailSignal {
    return [[[MerchantClient merchantShareDetail:self.pageSize pageNum:self.pageNum]
        doNext:^(id x) {
            GroupShareDetailsResponse *response = (GroupShareDetailsResponse *)x;
            NSMutableArray *rebateList = [[NSMutableArray alloc] initWithArray:self.dataSource];
            [rebateList addObjectsFromArray:[Rebate objectArrayWithKeyValuesArray:(NSArray *)response.rebateList]];
            if (rebateList.count > self.dataSource.count) {
                self.pageNum = @(self.pageNum.integerValue+1);
                self.dataSource = rebateList.copy;
            }
            else self.isNoMoreData = YES;
        }] doError:^(NSError *error) {
            self.error = error;
        }];
}

- (RACSignal *)takeListResetSignal {
    self.pageNum = @(1);
    self.isNoMoreData = NO;
    
    return self.takeListAddSignal;
}

- (RACSignal *)takeListAddSignal {
    return [[[MerchantClient takeListSignal:self.optype pageSize:self.pageSize pageNum:self.pageNum]
      doNext:^(id x) {
          GroupPredepositListResponse *response = (GroupPredepositListResponse *)x;
          NSMutableArray *takeCashList = [[NSMutableArray alloc] initWithArray:self.dataSource];
          if ([self.pageNum integerValue] == 1) {
              [takeCashList removeAllObjects];
          }
          [takeCashList addObjectsFromArray:[UPrepositLog objectArrayWithKeyValuesArray:(NSArray *)response.preCashList]];
          if (takeCashList.count > self.dataSource.count) {
              self.pageNum = @(self.pageNum.integerValue+1);
              self.dataSource = takeCashList.copy;
          }
          else self.isNoMoreData = YES;
      }] doError:^(NSError *error) {
          self.error = error;
      }];
}

@end
