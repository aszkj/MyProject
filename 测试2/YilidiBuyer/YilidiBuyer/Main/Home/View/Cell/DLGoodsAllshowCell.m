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
#import "UIView+Constraints.h"

@interface DLGoodsAllshowCell()
@property (weak, nonatomic) IBOutlet UILabel *normalGoodsMarkLabel;

@end

@implementation DLGoodsAllshowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (kScreenWidth == iPhone5_width) {
        self.productName.font = kSystemFontSize(12);
        self.normalGoodsMarkLabel.topConstraint.constant = 2;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

@implementation DLGoodsAllshowCell (setShopCartCellModel)

-(void)setGoodsAllshowCell:(GoodsModel *)model{

    [self.productImage sd_SetImgWithUrlStr:model.goodsThumbnail placeHolderImgName:nil];
    self.productName.text = model.goodsName;
    self.brandLabel.text = model.goodsStand;
    self.goodsCountChangeView.goodsModel = model;
    [self.goodsCountChangeView initUiFromShopCartGoodsId:model.goodsId];
    self.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
    };
    NSMutableAttributedString *vipMutubleStr = [[NSMutableAttributedString alloc] initWithString:@""];
    [vipMutubleStr appendAttributedString:(NSAttributedString *)kDefaultRMBStrWithPrice(model.goodsVipPrice.floatValue)];
    
    self.priceLabel.attributedText =  kRMBPriceStrWithPrice(model.goodsVipPrice.floatValue,14,14);
    
    NSMutableAttributedString *normalMutubleStr = [[NSMutableAttributedString alloc] initWithString:@""];
    [normalMutubleStr appendAttributedString:(NSAttributedString *)kDefaultRMBStrWithPrice(model.goodsOriginalPrice.floatValue)];
    self.oldPrice.attributedText =  kRMBPriceStrWithPrice(model.goodsOriginalPrice.floatValue,12,12);

    
}

@end
