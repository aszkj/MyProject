//
//  DLCommunityGoodsCollectionViewCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLHomeGoodsModel.h"

@interface DLCommunityGoodsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsStandLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsOriginalPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *addShopCartClickButton;

@end

@interface DLCommunityGoodsCollectionViewCell (setCellModel)

- (void)setCellModel:(DLHomeGoodsModel *)model;

@end