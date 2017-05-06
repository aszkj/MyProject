//
//  DLDispatchGoodsCell.m
//  YilidiSeller
//
//  Created by yld on 16/6/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLDispatchGoodsCell.h"
#import "UIImageView+sd_SetImg.h"
#import "ProjectRelativeMaco.h"

@implementation DLDispatchGoodsCell

- (void)awakeFromNib {
    // Initialization code
    if (kScreenWidth == iPhone5_width) {
        self.productNameLabel.font = kSystemFontSize(12);
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)setSelectedAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (self.selectDispatchGoodsBlock) {
        self.selectDispatchGoodsBlock(button);
    }
}


@end

@implementation DLDispatchGoodsCell (setGoodsModel)

-(void)setCellModel:(GoodsModel *)model{
    
    [self.productImageView sd_SetImgWithUrlStr:model.goodsThumbnail placeHolderImgName:nil];
    self.purchasePriceLabel.attributedText = kRMBPriceStrWithPrice(model.goodsPurchasePrice.floatValue,12,12);
    self.miniteRepositorystockLabel.text = model.minuteResposityStock.stringValue;
    self.storeStockLabel.text = model.goodsStock.stringValue;
    self.productNameLabel.text = model.goodsName;
    self.basicOrderNumberLabel.text = jFormat(@"起订数量（%ld件）",(long)model.basicOrderNumber.integerValue);
    WEAK_SELF
    self.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
        emptyBlock(weak_self.changeDispatchGoodsCountBlock,nowCount,isAdd);
    };
    [self.goodsCountChangeView initUiFromShopCartGoodsId:model.goodsId];
    self.goodsCountChangeView.goodsModel = model;

}



@end
