//
//  QueryProgressViewModel.h
//  Merchants_JingGang
//
//  Created by ray on 15/9/16.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_ViewModel.h"

@interface QueryProgressViewModel : XKO_ViewModel

@property (nonatomic) StoreApplyInfo *applyInfo;
@property (nonatomic) RACCommand *queryProgressCommand;

@end
