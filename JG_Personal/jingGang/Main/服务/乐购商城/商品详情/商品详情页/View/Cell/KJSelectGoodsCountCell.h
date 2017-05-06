//
//  KJSelectGoodsCountCell.h
//  jingGang
//
//  Created by 张康健 on 15/8/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJSelectGoodsCountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *countButton;
@property (weak, nonatomic) IBOutlet UIButton *subCountButton;


@property (nonatomic, assign)NSInteger buyGoodsCount;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

//库存
@property (nonatomic, assign)NSInteger goodsStockCount;


@end
