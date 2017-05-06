//
//  DLHomeRecommendCollectionViewCell.h
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRecommondFruitHoriznalCount 3
#define kRecommondFruitCellImgToSideEdge 8
#define kRecommondFruitCellWidth (kScreenWidth / kRecommondFruitHoriznalCount * 1.0)
#define kRecommondFruitCellImgWidth (kRecommondFruitCellWidth - kRecommondFruitCellImgToSideEdge * 2)
#define kRecommondFruitCellImgHeight kRecommondFruitCellImgWidth/1.0
#define kRecommondFruitCellHeight (kRecommondFruitCellImgHeight + 62)

@interface DLHomeRecommendCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *recommonFruitImgView;
@property (weak, nonatomic) IBOutlet UILabel *recommonFruitTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommondFruitNowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommondFruitOriginalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *recommondFruitAddShopCartButton;
@property (weak, nonatomic) IBOutlet UIButton *addShopCartClickButton;

@end
