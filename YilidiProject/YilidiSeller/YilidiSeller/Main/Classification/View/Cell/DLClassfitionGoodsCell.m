//
//  DLClassfitionGoodsCell.m
//  YilidiSeller
//
//  Created by mm on 17/1/9.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLClassfitionGoodsCell.h"
#import "UIImageView+sd_SetImg.h"
#import "ProjectRelativeMaco.h"
#import "GlobleConst.h"
#import "NSArray+extend.h"

@interface DLClassfitionGoodsCell ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *labelConstraints;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_normalPriceLabelToLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_vipPriceLabelToLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_LeftStockLabelToLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_goodsImgViewToLeft;

@end

@implementation DLClassfitionGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (kScreenWidth == iPhone5_width) {
        [self.labels setArrUisFont:kSystemFontSize(10.0)];
        [self.labelConstraints changeUiDetaConstraint:-6];
    }
    self.constraint_goodsImgViewToLeft.constant = IsShareStock ? 13 : 44;
    self.selectedButton.hidden = IsShareStock;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)extralSelectAction:(id)sender {
    [self selectButtonAction:self.selectedButton];
}

- (IBAction)selectButtonAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    emptyBlock(self.selectGoodsBlock,button);
    
}


@end

@implementation DLClassfitionGoodsCell (setCellModel)

-(void)setGoodsCellModel:(GoodsModel *)model{
//    model.goodsSalesVulome = @(9000);
//    model.goodsStock = @(90000);
//    model.goodsVipPrice = @(323.22);
//    model.goodsOriginalPrice = @(323.22);
//    
    NSArray *numbersArr = @[model.goodsSalesVulome,model.goodsOriginalPrice,model.goodsVipPrice,model.goodsStock];
    if ([numbersArr isTotalNumbersBitLengthBiggerThanMinMaxLength:12]) {
        [self.labelConstraints changeUiDetaConstraint:-2];
    }
    
    [self.productImageView sd_SetImgWithUrlStr:model.goodsThumbnail placeHolderImgName:nil];
    self.salesVulomeLabel.text = model.goodsSalesVulome.stringValue;
    self.stockLabel.text = model.goodsStock.stringValue;
    self.productNameLabel.text = model.goodsName;
    self.selectedButton.selected = model.selected;
    CGFloat priceFont = 12;
    if (kScreenWidth == iPhone5_width) {
        priceFont = 10;
    }
    self.vipPriceLabel.attributedText = kRMBPriceStrWithPrice(model.goodsVipPrice.floatValue,priceFont,priceFont);
    self.oldPriceLabel.attributedText = kRMBPriceStrWithPrice(model.goodsOriginalPrice.floatValue,priceFont,priceFont);
}

@end

