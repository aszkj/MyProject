//
//  FeelBackViewModel.h
//  Operator_JingGang
//
//  Created by ray on 15/11/6.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "XKO_ViewModel.h"

@interface FeelBackViewModel : XKO_ViewModel

@property (nonatomic) NSString *content;
@property (nonatomic) RACCommand *commitCommand;

@end
