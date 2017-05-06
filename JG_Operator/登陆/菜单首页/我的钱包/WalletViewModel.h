//
//  WalletViewModel.h
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_ViewModel.h"

@interface WalletViewModel : XKO_ViewModel

@property (nonatomic) NSAttributedString *yunbiString;
@property (nonatomic) NSArray *dataSource;

- (void)getYunbiResques;

@end
