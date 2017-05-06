//
//  DLShopCartCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/4.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLShopCartCell.h"
#import "UIImageView+sd_SetImg.h"
#import "ProjectRelativeMaco.h"

@implementation DLShopCartCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteAction:(id)sender {
    if (self.deleteShopCartGoodsBlock) {
        self.deleteShopCartGoodsBlock();
    }
}

- (IBAction)setSelectedAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (self.selectShopCartGoodsBlock) {
        self.selectShopCartGoodsBlock(button);
    }
}

@end

@implementation DLShopCartCell (setShopCartCellModel)

-(void)setShopCartCellModel:(GoodsModel *)model {

    [self.goodsImgView sd_SetImgWithUrlStr:model.goodsThumbnail placeHolderImgName:nil];
    self.goodsNameLabel.text = model.goodsName;
    self.goodsNowPriceLabel.text = kPriceFloatValueToRMB(model.goodsPurchasePrice.floatValue);
    self.goodsStandLabel.text = model.goodsStand;
    self.allSelectedButton.selected = model.selected;
    WEAK_SELF
    self.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
        if (weak_self.changeShopCartGoodsCountBlock) {
            weak_self.changeShopCartGoodsCountBlock(nowCount,isAdd);
        }
        [weak_self setNeedsLayout];
    };
    [self.goodsCountChangeView initUiFromShopCartGoodsId:model.goodsId];
    self.goodsCountChangeView.goodsModel = model;
}

@end

