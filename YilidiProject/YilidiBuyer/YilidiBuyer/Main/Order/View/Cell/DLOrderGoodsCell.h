//
//  DLOrderGoodsCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
@interface DLOrderGoodsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *goodsCountButton;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;

@end

@interface DLOrderGoodsCell (setCellModel)

- (void)setCellModel:(GoodsModel *)model;

@end