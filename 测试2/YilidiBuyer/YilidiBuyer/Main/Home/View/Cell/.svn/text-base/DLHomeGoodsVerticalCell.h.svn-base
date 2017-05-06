//
//  DLHomeGoodsVerticalCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartGoodsNumberChangeView.h"
@class GoodsModel;
@interface DLHomeGoodsVerticalCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UIImageView *goodsExerciseImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsStandlabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsOriginalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsVipPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeightConstraint;
@property (weak, nonatomic) IBOutlet ShopCartGoodsNumberChangeView *goodsCountChangeView;

@end


@interface DLHomeGoodsVerticalCell (setCellModel)

- (void)setCellModel:(GoodsModel *)model;
@end