//
//  KJGuessyouLikeCollectionCell.h
//  商品详情页collectionView测试
//
//  Created by 张康健 on 15/8/8.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailModel.h"
#define kCareChoosenGoodsCellImgWith (kScreenWidth / 2 - 2*10)
#define kCareChoosenGoodsCellHeight (kCareChoosenGoodsCellImgWith + 65)
#define kCareChoosenGoodsCellHeaderHeight 20
@interface SHKJGuessyouLikeCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;

//手机专享价背景view
@property (weak, nonatomic) IBOutlet UIView *phoneSpecialSharePriceView;
//手机专享价label
@property (weak, nonatomic) IBOutlet UILabel *phoneSpecialSharePriceLabel;

//价格背景view
@property (weak, nonatomic) IBOutlet UIView *priceBgView;
//价格label
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic,strong)GoodsDetailModel *model;

@end
