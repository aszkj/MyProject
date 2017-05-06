//
//  DLSearchedGoodsCell.m
//  YilidiSeller
//
//  Created by yld on 16/6/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSearchedGoodsCell.h"
#import "UIImageView+sd_SetImg.h"
#import "ProjectRelativeMaco.h"
#import "GlobleConst.h"

@implementation DLSearchedGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)offShelfAction:(id)sender {
    emptyBlock(self.onOffShelfBlock,@(0));
}

- (IBAction)onShelfAction:(id)sender {
    emptyBlock(self.onOffShelfBlock,@(1));
}

@end

@implementation DLSearchedGoodsCell (setGoodsModel)

-(void)setCellModel:(GoodsModel *)model{
    
    [self.productImageView sd_SetImgWithUrlStr:model.goodsThumbnail placeHolderImgName:nil];
    self.salesVulomeLabel.text = model.goodsSalesVulome.stringValue;
    self.stockLabel.text = model.goodsStock.stringValue;
    self.productNameLabel.text = model.goodsName;
    self.vipPriceLabel.attributedText = kRMBPriceStrWithPrice(model.goodsVipPrice.floatValue,12,12);
    self.oldPriceLabel.attributedText = kRMBPriceStrWithPrice(model.goodsOriginalPrice.floatValue,12,12);
    [self configureOnOffShelfUiByGoodsModel:model];
}

-(void)configureOnOffShelfUiByGoodsModel:(GoodsModel *)model {
    
  self.onOffShelfMarkButton.enabled = model.goodsOnShelf.integerValue;
  self.offShelfButton.enabled = model.goodsOnShelf.integerValue;
  self.onShelfButton.enabled = !model.goodsOnShelf.integerValue;
  self.offShelfButton.selected = model.goodsOnShelf.integerValue;
  self.onShelfButton.selected = !model.goodsOnShelf.integerValue;
  self.offShelfButton.backgroundColor = model.goodsOnShelf.integerValue ? KSelectedBgColor : [UIColor clearColor];
  self.onShelfButton.backgroundColor = model.goodsOnShelf.integerValue ?  [UIColor clearColor]:KSelectedBgColor;
}


@end

