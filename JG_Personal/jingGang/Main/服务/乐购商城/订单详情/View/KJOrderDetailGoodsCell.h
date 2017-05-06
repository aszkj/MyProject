//
//  KJOrderDetailGoodsCell.h
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsInfoModel;
@interface KJOrderDetailGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, strong)GoodsInfoModel *goodsInfoModel;
@property (weak, nonatomic) IBOutlet UIImageView *od_goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *od_goodsNameLabel;
//商品规格label
@property (weak, nonatomic) IBOutlet UILabel *od_goodsCationLabel;
@property (weak, nonatomic) IBOutlet UILabel *od_goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *od_goodsCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *applyReturnGoodsButton;

@property (nonatomic, strong)NSNumber *goodsOrderID;
//订单状态
@property (nonatomic, assign)NSNumber *orderStatusNum;


@end
