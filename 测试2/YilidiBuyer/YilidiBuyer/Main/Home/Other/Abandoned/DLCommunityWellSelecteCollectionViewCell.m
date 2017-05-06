//
//  DLCommunityWellSelecteCollectionViewCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/10.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCommunityWellSelecteCollectionViewCell.h"
#import "ProjectRelativeMaco.h"
#import "DLHomeGoodsModel.h"

@implementation DLCommunityWellSelecteCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

@end
@implementation DLCommunityWellSelecteCollectionViewCell (setCellModel)

-(void)setCellModel:(DLHomeGoodsModel *)model {
    
    [self.goodsImgView sd_SetImgWithUrlStr:model.imgUrl placeHolderImgName:nil];
//    if (!isEmpty(model.oldPrice)) {
        self.goodsOriginalPriceLabel.text = kPriceFloatValueToRMB(model.oldPrice.doubleValue);
//    }
    self.goodsPriceLabel.text = kPriceFloatValueToRMB(model.goodsPrice.doubleValue);
}
@end