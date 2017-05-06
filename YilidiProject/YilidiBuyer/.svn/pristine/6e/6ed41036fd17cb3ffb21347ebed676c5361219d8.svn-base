//
//  DLFreshFruitCollectionViewCell.h
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFreshFruitHoriznalCount 3
#define kFreshFruitCellImgToSideEdge 8
#define kFreshFruitCellWidth (kScreenWidth / kFreshFruitHoriznalCount * 1.0)
#define kFreshFruitCellImgWidth (kFreshFruitCellWidth - kFreshFruitCellImgToSideEdge * 2)
#define kFreshFruitCellImgHeight kFreshFruitCellImgWidth/1.0
#define kFreshFruitCellHeight (kFreshFruitCellImgHeight + 126)
@class DLHomeGoodsModel;
@interface DLFreshFruitCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsOriginalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *addShopCartClickButton;

@property (nonatomic,strong)DLHomeGoodsModel *goodsModel;


@end
