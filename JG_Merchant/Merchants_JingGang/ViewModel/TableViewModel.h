//
//  TableViewModel.h
//  Merchants_JingGang
//
//  Created by ray on 15/9/15.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_TableViewModel.h"

@interface TableViewModel : XKO_TableViewModel

/**
 *  获取提现列表数据，处理返回的异常等
 *
 *  @return 提现列表信号
 */
- (RACSignal *)takeListAddSignal;
/**
 *  获取分润明细列表，处理返回的异常等
 *
 *  @return 分润明细列表信号
 */
- (RACSignal *)shareDetailSignal;

@end
