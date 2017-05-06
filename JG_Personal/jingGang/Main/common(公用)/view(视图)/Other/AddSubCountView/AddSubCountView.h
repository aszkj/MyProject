//
//  AddSubCountView.h
//  jingGang
//
//  Created by 张康健 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobeObject.h"

typedef void (^CountChangedBlk)(NSInteger);

@interface AddSubCountView : UIView
//购买数量
@property (nonatomic, assign)NSInteger buyGoodsCount;
@property (copy, nonatomic) CountChangedBlk countChangedBlk;

+ (id)showInContentView:(UIView *)contentView goodStockCount:(NSInteger)goodsStockCount size:(CGSize)size;


@end
