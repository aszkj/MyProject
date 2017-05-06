//
//  DLOrderDetailCell.m
//  YilidiSeller
//
//  Created by yld on 16/7/4.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderDetailCell.h"
#import "ProjectRelativeMaco.h"
#import "UIImageView+sd_SetImg.h"

@implementation DLOrderDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@implementation DLOrderDetailCell (setCellModel)

- (void)setCellModel:(GoodsModel *)goodsModel {
    [self.goodsImgView sd_SetImgWithUrlStr:goodsModel.goodsThumbnail placeHolderImgName:nil];
    self.goodsNameLabel.text = goodsModel.goodsName;
    self.goodsCountLabel.text = jFormat(@"x%ld",goodsModel.goodsNumber.integerValue);
    self.productSpec.text = goodsModel.goodsStand;
    self.goodsPriceLabel.attributedText = kDefaultRMBStrWithPrice(goodsModel.goodsBuyPrice.floatValue);
}

@end