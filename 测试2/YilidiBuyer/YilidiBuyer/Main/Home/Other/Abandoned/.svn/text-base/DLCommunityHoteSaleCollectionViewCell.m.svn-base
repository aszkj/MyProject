//
//  DLHomeRecommendCollectionViewCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCommunityHoteSaleCollectionViewCell.h"
#import "DLHomeGoodsModel.h"
#import "ProjectRelativeMaco.h"

@implementation DLCommunityHoteSaleCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

@end

@implementation DLCommunityHoteSaleCollectionViewCell (setCellModel)

-(void)setCellModel:(DLHomeGoodsModel *)model {
    
    [self.goodsImgView sd_SetImgWithUrlStr:model.imgUrl placeHolderImgName:nil];
    
    self.goodsPriceLabel.text = kPriceFloatValueToRMB(model.goodsPrice.doubleValue);
    if (isEmpty(model.goodsName)) {
        model.goodsName = @"测试商品";
    }
    self.goodsTitleLabel.text = model.goodsName;
//    if (!isEmpty(model.oldPrice)) {
        self.goodsOriginalPriceLabel.text = kPriceFloatValueToRMB(model.oldPrice.doubleValue);
//    }
}
@end