//
//  WSJShoppingCartHeaderView.h
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSJShoppingCartModel.h"


@interface WSJShoppingCartHeaderView : UIView


- (void) noSelect;

- (void) willHearderWithModel:(WSJShoppingCartModel *)model;


@property (nonatomic, copy) void (^editBlock)(BOOL b);
@property (nonatomic, copy) void (^selectBlock)(BOOL b);
@property (nonatomic, copy) void (^selectHeaderBlock)(void);


@end
