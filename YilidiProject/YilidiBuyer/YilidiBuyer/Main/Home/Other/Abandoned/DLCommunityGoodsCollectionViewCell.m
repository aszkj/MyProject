//
//  DLCommunityGoodsCollectionViewCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCommunityGoodsCollectionViewCell.h"
#import "ProjectRelativeMaco.h"

@implementation DLCommunityGoodsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

@end

@implementation DLCommunityGoodsCollectionViewCell (setCellModel)

- (void)setCellModel:(DLHomeGoodsModel *)model {
    
    [self.goodsImgView sd_SetImgWithUrlStr:model.imgUrl placeHolderImgName:nil];
    self.goodsTitleLabel.text = model.goodsName;
    self.goodsNowPriceLabel.text = kPriceFloatValueToRMB(model.goodsPrice.doubleValue);
    self.goodsOriginalPriceLabel.text = kPriceFloatValueToRMB(model.oldPrice.doubleValue);

}
@end