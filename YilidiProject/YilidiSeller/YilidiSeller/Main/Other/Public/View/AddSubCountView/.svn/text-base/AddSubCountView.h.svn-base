  //
//  AddSubCountView.h
//  jingGang
//
//  Created by 张康健 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobeMaco.h"

typedef void (^CountChangedBlk)(NSInteger,BOOL isAdd);


@interface AddSubCountView : UIView
//购买数量
@property (nonatomic, assign)NSInteger buyGoodsCount;

//库存
@property (nonatomic, assign)NSInteger goodsStockCount;

@property (copy, nonatomic) CountChangedBlk countChangedBlk;

+ (id)showInContentView:(UIView *)contentView goodStockCount:(NSInteger)goodsStockCount size:(CGSize)size;


@end
