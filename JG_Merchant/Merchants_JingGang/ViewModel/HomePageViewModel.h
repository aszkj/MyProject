//
//  HomePageViewModel.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/12.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKO_ViewModel.h"

@interface HomePageViewModel : XKO_ViewModel

@property (nonatomic, readonly) StoreIndex *merchant;
@property (nonatomic) RACCommand *merchantInfoCommand;

@end
