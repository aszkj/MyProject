//
//  DLGoodsAllshowCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsAllshowCell.h"
#import "UIImageView+sd_SetImg.h"
#import "ProjectRelativeMaco.h"

@interface DLGoodsAllshowCell()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *otherLabels;

@end

@implementation DLGoodsAllshowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (kScreenWidth == iPhone5_width) {
        self.productName.font = kSystemFontSize(12);
        for (UILabel *otherLabel in self.otherLabels) {
            otherLabel.font = kSystemFontSize(10);
        }
    }
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

@implementation DLGoodsAllshowCell (setShopCartCellModel)

-(void)setGoodsAllshowCell:(GoodsModel *)model{

    [self.productImage sd_SetImgWithUrlStr:model.goodsThumbnail placeHolderImgName:nil];
    self.salesVulomeLabel.text = model.goodsSalesVulome.stringValue;
    self.stockLabel.text = model.goodsStock.stringValue;
    self.productName.text = model.goodsName;
    self.selectedButton.selected = model.selected;
    CGFloat priceFont = 12;
    if (kScreenWidth == iPhone5_width) {
        priceFont = 10;
    }
    self.vipPriceLabel.attributedText = kRMBPriceStrWithPrice(model.goodsVipPrice.floatValue,priceFont,priceFont);
    self.oldPrice.attributedText = kRMBPriceStrWithPrice(model.goodsOriginalPrice.floatValue,priceFont,priceFont);
}

@end
