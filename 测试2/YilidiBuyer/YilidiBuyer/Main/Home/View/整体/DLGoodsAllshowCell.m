//
//  DLGoodsAllshowCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/9.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsAllshowCell.h"
#import "UIImageView+sd_SetImg.h"
@implementation DLGoodsAllshowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DLGoodsAllshowCell (setShopCartCellModel)

-(void)setGoodsAllshowCell:(DLAllshowModel *)model{

    [self.productImage sd_SetImgWithUrlStr:model.imgUrl placeHolderImgName:nil];
    self.productName.text = model.goodsName;
    self.CommodityDes.text = model.desc;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.oldPrice.text = [NSString stringWithFormat:@"¥%@",model.oldPrice];
    
}

@end
