//
//  DLGoodsSearchCell.m
//  YilidiSeller
//
//  Created by mm on 17/1/10.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLGoodsSearchCell.h"
#import "UIImageView+sd_SetImg.h"
#import "ProjectRelativeMaco.h"
#import "ProjectStandardUIDefineConst.h"
#import "GlobleConst.h"
#import "NSArray+extend.h"

@interface DLGoodsSearchCell()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *labelConstraints;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_lineViewTobottom;
@property (weak, nonatomic) IBOutlet UIView *bottomOperateOnOffShelfView;

@end

@implementation DLGoodsSearchCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (kScreenWidth == iPhone5_width) {
        [self.labels setArrUisFont:kSystemFontSize(10.0)];
        [self.labelConstraints changeUiDetaConstraint:-6];
    }
    self.constraint_lineViewTobottom.constant = IsShareStock ? 25 : 0;
#warning 显然只不要的部分只减少高度是不行的，不要的部分对应的view也要隐藏
    self.onOffShelfButton.hidden = IsShareStock;
    self.bottomOperateOnOffShelfView.hidden = IsShareStock;
}

- (IBAction)onOffShelfAction:(id)sender {
    UIButton *shelfButton = (UIButton *)sender;
    NSInteger shelfNumber = shelfButton.selected ? 1 : 0;
    emptyBlock(self.onOffShelfBlock,@(shelfNumber));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

@implementation DLGoodsSearchCell (setGoodsModel)

-(void)setCellModel:(GoodsModel *)model{
    
    NSArray *numbersArr = @[model.goodsSalesVulome,model.goodsOriginalPrice,model.goodsVipPrice,model.goodsStock];
    if ([numbersArr isTotalNumbersBitLengthBiggerThanMinMaxLength:12]) {
        [self.labelConstraints changeUiDetaConstraint:-2];
    }

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
    self.onOffShelfButton.selected = !model.goodsOnShelf.integerValue;
    self.onOffShelfButton.backgroundColor = model.goodsOnShelf.integerValue ? [UIColor clearColor] : KSelectedBgColor;
//    self.onOffShelfButton.titleLabel.textColor = model.goodsOnShelf.integerValue ? KTextColor : [UIColor whiteColor];
    
}


@end
