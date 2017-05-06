//
//  KJGoodsDetailViewController.h
//  jingGang
//
//  Created by 张康健 on 15/8/5.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailModel.h"

@interface KJGoodsDetailViewController : UIViewController

//商品详情字典
//@property (nonatomic, copy)NSMutableDictionary *goodsDetailDic;
//商品详情model
@property (nonatomic, strong)GoodsDetailModel *goodsDetailModel;

//选择的商品规格的id字符串
@property (nonatomic, copy)NSString *selecdGoodsCationIdStr;

@property (nonatomic, strong)NSNumber *goodsID;


@end
