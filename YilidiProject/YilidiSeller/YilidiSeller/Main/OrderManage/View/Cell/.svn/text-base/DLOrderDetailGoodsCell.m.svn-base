//
//  DLOrderDetailGoodsCell.m
//  YilidiSeller
//
//  Created by yld on 16/6/7.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderDetailGoodsCell.h"
#import "UIImageView+sd_SetImg.h"

@implementation DLOrderDetailGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
@implementation DLOrderDetailGoodsCell (setCellModel)

- (void)setCellModel:(GoodsModel *)goodsModel {
    [self.goodsImgView sd_SetImgWithUrlStr:goodsModel.goodsThumbnail placeHolderImgName:nil];
    self.goodsNameLabel.text = goodsModel.goodsName;
    self.goodsCountLabel.text = [NSString stringWithFormat:@"x%ld",goodsModel.goodsNumber.integerValue];

}

@end